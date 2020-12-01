using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace NorWinds_V2_Site
{
    public partial class Cart : Page


    {
        private NorwinDBTableAdapters.CartTableAdapter cart = new NorwinDBTableAdapters.CartTableAdapter();
        private NorwinDBTableAdapters.ProductsTableAdapter products = new NorwinDBTableAdapters.ProductsTableAdapter();
        private NorwinDBTableAdapters.OrdersTableAdapter orders = new NorwinDBTableAdapters.OrdersTableAdapter();
        private NorwinDBTableAdapters.Order_DetailsTableAdapter orderDetails = new NorwinDBTableAdapters.Order_DetailsTableAdapter();
        private string custID;


        protected void Page_Load(object sender, EventArgs e)
        {
            custID = "GROSR";
            lsvCart.DataSource = cart.GetDataByCustID(custID);
            lsvCart.DataBind();
            txtShipDate.Text = DateTime.Now.ToShortDateString();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {

            //casting sender to a Button to make use of the CommandArgument property. Not sure if this is good practice, feels a little hacky.
            Button btnRm = (Button)sender;

            //Must pass it all as one string from the page, so it takes a few extra steps to split it up into the required types.  
            string[] theArgs = btnRm.CommandArgument.Split(',');

            int productId = int.Parse(theArgs[0]);
            int cartItemQuantity = int.Parse(theArgs[1]);
            int cartItemId = int.Parse(theArgs[2]);
            int currentlyInStock = Convert.ToInt32(products.GetInStockByProdID(productId));

            //delete the row from the db in the cart
            cart.removeCartItem(cartItemId);

            //refresh the view
            lsvCart.DataSource = cart.GetDataByCustID(custID);
            lsvCart.DataBind();

            products.UpdateInStock((short)(cartItemQuantity + currentlyInStock), productId);
        }


        protected void btnCheckShip_Click(object sender, EventArgs e)
        {//placeholder shipping time of three days. In the real world, this would look up the time to ship in dbo.Shippers
            DateTime userDate = new DateTime();
            if (DateTime.TryParse(txtShipDate.Text, out userDate))
            {
                lblArrivalDate.Text = userDate.AddDays(3).ToShortDateString();
            }
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
           
            //get the cart items into workable datatype
            DataTable onOrder = null;
            onOrder = cart.GetDataByCustID(custID);

            //ensure customer is not trying to place an empty order. doing it this way because the cart is in the DB, 
            //and Im not sure how to apply a client side validation process to that.
            if (onOrder.Rows.Count > 0)
            {
                DateTime orderDate;
                DateTime shipDate;

                orderDate = DateTime.Parse(txtShipDate.Text);
                shipDate = orderDate.AddDays(3);


                //insert the appropriate row in orders and return the orderID
                int orderID = Convert.ToInt32(orders.InsertOrder(custID, 1, orderDate, shipDate, shipDate, 1, (decimal)99.99, "testCasesLTD", "123 Fake st.", "Made-upsville", "Province", "Z9Z 9Z9", "Country"));


                //insert the appropriate rows in orderdetails
                foreach (DataRow row in onOrder.Rows)
                {//||ProductName || Quantity || ProductID || CustomerID || SessionID || CartItemID || UnitPrice || SubTotal ||

                    int prodID = Convert.ToInt32(row.ItemArray[2]);
                    decimal unitPrice = Convert.ToDecimal(row.ItemArray[6]);
                    int qty = Convert.ToInt32(row.ItemArray[1]);

                    orderDetails.InsertRow(orderID, prodID, unitPrice, (short)qty, 0.0F);
                }

                //empty the cart
                foreach (DataRow row in onOrder.Rows)
                {
                    int cartItemID = Convert.ToInt32(row[5]);
                    cart.removeCartItem(cartItemID);
                }

                //rebind the listview to clear the screen
                lsvCart.DataSource = cart.GetDataByCustID(custID);
                lsvCart.DataBind();

                //Inform the user
                lblMessage.Text = "Thank you. Your order has been placed successfully.";
            }
            else
            {
                lblMessage.Text = "Empty order cannot be placed.";
            }
        }
    }
}
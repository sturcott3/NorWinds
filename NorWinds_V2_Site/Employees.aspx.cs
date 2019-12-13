using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace NorWinds_V2_Site
{
    public partial class Employees : System.Web.UI.Page
    {
        private NorwinDBTableAdapters.CartTableAdapter cart = new NorwinDBTableAdapters.CartTableAdapter();
        private NorwinDBTableAdapters.ProductsTableAdapter products = new NorwinDBTableAdapters.ProductsTableAdapter();
        private NorwinDBTableAdapters.OrdersTableAdapter orders = new NorwinDBTableAdapters.OrdersTableAdapter();
        private NorwinDBTableAdapters.Order_DetailsTableAdapter orderDetails = new NorwinDBTableAdapters.Order_DetailsTableAdapter();
        private string custID;

        protected void Page_Load(object sender, EventArgs e)
        {
            txtShipDate.Text = DateTime.Now.ToLongDateString();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            custID = cbxCustomer.SelectedValue;
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
            custID = cbxCustomer.SelectedValue;
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
                lblMessage.CssClass = "confirmation-message";
                lblMessage.Text = "Thank you. Your order has been placed successfully.";
            }
            else
            {
                lblMessage.CssClass = "validator-message";
                lblMessage.Text = "Empty order cannot be placed.";
            }
        }

        protected void btnGetCustCart_Click(object sender, EventArgs e)
        {
            custID = cbxCustomer.SelectedValue;
            lblMessage.Text = "";
            lsvCart.DataSource = cart.GetDataByCustID(custID);
            lsvCart.DataBind();
        }

        protected void btnAddToOrder_Click(object sender, EventArgs e)
        {
                int qty;
                //check the stock for the selected item, print out the stock level and set the validator's max value if it is below requested
                if (int.TryParse(cbxQuantity.SelectedValue, out qty) && qty >= 1)
                {
                    int unitsInStock = Convert.ToInt32(products.GetInStockByProdID(Convert.ToInt32(cbxItemName.SelectedValue)));

                    if (unitsInStock < Convert.ToInt32(cbxQuantity.SelectedValue))
                    {
                        if (unitsInStock > 0)
                        {
                            //tell the user
                            lblMessage.CssClass = "validator-message";
                            lblMessage.Text = "Item only has " + unitsInStock + " units in stock";
                        }
                        else
                        {
                            //tell the user
                            lblMessage.CssClass = "validator-message";
                            lblMessage.Text = "Item out of Stock.";
                        }
                    }
                    else
                    {
                        //Add the requested number of items to the cart under the selected client's name
                        if (cbxCustomer.SelectedValue != "")
                        {
                            //get input
                            int numberToOrder = int.Parse(cbxQuantity.SelectedValue);

                            float unitPrice = (float)products.GetUnitPriceByProdID(Convert.ToInt32(cbxItemName.SelectedValue));

                            float subTotal = (float)numberToOrder * unitPrice;

                            string prodName = cbxItemName.SelectedItem.ToString();

                            int prodID = Convert.ToInt32(cbxItemName.SelectedValue);

                            custID = cbxCustomer.SelectedValue;

                            //add the selected quantity of the item to the cart table in the DB 
                            cart.InsertCartItem(prodName, numberToOrder, prodID, custID, Session.SessionID, unitPrice, subTotal);
                            products.UpdateInStock((short)(unitsInStock - numberToOrder), prodID);

                            lblMessage.CssClass = "confirmation-message";
                            lblMessage.Text = numberToOrder + " items added to order.";

                            lsvCart.DataSource = cart.GetDataByCustID(custID);
                            lsvCart.DataBind();
                        }
                        else
                        {
                            lblMessage.CssClass = "validator-message";
                            lblMessage.Text = "Please select a client";
                        }
                    }
                }
                else
                {
                    lblMessage.Text = "Please select a quantity between 1 and max in stock";
                    lblMessage.CssClass = "validator-message";
                }

        }
            
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/*Author Sam Turcotte
 * This class acts as the "shopping" interface for the user, allowing them to add items to a 
 * "cart" that persists between sessions. This page also uses a client side validation process to ensure that there are enough
 * units in stock before allowing the user to add the items to their cart. 
 * 
 * 
 * TODO : add a second validation to the server side, or handle the violation of CK_UnitsInStock (database check constraint)
 */
namespace NorWinds_V2_Site
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        private int unitsInStock;
        private int prodID;
        private string prodName;
        private string custID;

        protected void Page_Load(object sender, EventArgs e)
        {
            NorwinDBTableAdapters.ProductsTableAdapter products = new NorwinDBTableAdapters.ProductsTableAdapter();

            //get the product Id from the query string
            prodID = int.Parse(Request.QueryString[0]);

            //get the other needed info from various queries
            //TODO get this from the logged in account
            custID = "GROSR";
            prodName = products.GetNameByProdID(prodID).ToString();


            //use the product id to call my scalar SQL statement to get the number of units in stock
            unitsInStock = Convert.ToInt32(products.GetInStockByProdID(prodID));

            if (unitsInStock > 0)
            {
                //set the max value of the validator to be the amount thats in stock
                vldQuantity.MaximumValue = unitsInStock.ToString();
            }
            else
            {
                vldQuantity.MinimumValue = "0";
                vldQuantity.MaximumValue = "0";
            }
  
            lsvProdDetails.DataSource = products.GetDataByProdID(Convert.ToInt32(Request.QueryString[0]));
            lsvProdDetails.DataBind();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            //make sure that there are enough units in stock
            if (vldQuantity.IsValid) //<stretch>Should also have server side validation in case of multiple users/connections</stretch>
            {
                NorwinDBTableAdapters.CartTableAdapter cart = new NorwinDBTableAdapters.CartTableAdapter();
                NorwinDBTableAdapters.ProductsTableAdapter products = new NorwinDBTableAdapters.ProductsTableAdapter();

                //get input
                int numberToOrder = int.Parse(cbxQuantity.SelectedValue);

                float unitPrice = (float)products.GetUnitPriceByProdID(Convert.ToInt32(Request.QueryString[0]));

                float subTotal = (float)numberToOrder * unitPrice;

                //add the selected quantity of the item to the cart table in the DB 
                cart.InsertCartItem(prodName, numberToOrder, prodID, custID, Session.SessionID, unitPrice, subTotal);
                products.UpdateInStock((short)(unitsInStock - numberToOrder), prodID);

                lsvProdDetails.DataSource = products.GetDataByProdID(Convert.ToInt32(Request.QueryString[0]));
                lsvProdDetails.DataBind();

                lblItemAdded.Text = numberToOrder + " items added to order.";
            }
            else
            {
                lblItemAdded.Text = "...";
            }
        }
    }
}
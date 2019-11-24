using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NorWinds_V2_Site
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        private int unitsInStock;
        private int prodID;

        protected void Page_Load(object sender, EventArgs e)
        {
            NorwinDBTableAdapters.ProductsTableAdapter products = new NorwinDBTableAdapters.ProductsTableAdapter();

            //get the product Id from the query string
            prodID = int.Parse(Request.QueryString[0]);

            //use the product id to call my scalar SQL statement to get the number of units in stock
            unitsInStock = Convert.ToInt32(products.GetInStockByProdID(prodID));

            //set the max value of the validator to be the amount thats in stock
            vldQuantity.MaximumValue = unitsInStock.ToString();
        }
    }
}
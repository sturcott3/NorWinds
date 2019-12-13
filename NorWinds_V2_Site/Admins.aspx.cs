using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NorWinds_V2_Site
{
    public partial class Administrators : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGetCustOrders_Click(object sender, EventArgs e)
        {
            NorwinDBTableAdapters.OrdersTableAdapter orders = new NorwinDBTableAdapters.OrdersTableAdapter();
            lsvOrders.DataSource = orders.GetOrdersByCustID(cbxCustomer.SelectedValue);
            lsvOrders.DataBind();
        }

        protected void btnGetDateOrders_Click(object sender, EventArgs e)
        {
            NorwinDBTableAdapters.OrdersTableAdapter orders = new NorwinDBTableAdapters.OrdersTableAdapter();
            lsvOrders.DataSource = orders.GetOrdersByRequiredDate(DateTime.Parse(cbxDate.SelectedValue));
            lsvOrders.DataBind();
        }
    }
}
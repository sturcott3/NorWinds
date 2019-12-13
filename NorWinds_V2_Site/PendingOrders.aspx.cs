using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NorWinds_V2_Site
{
    public partial class PendingOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NorwinDBTableAdapters.CustomersTableAdapter cust = new NorwinDBTableAdapters.CustomersTableAdapter();

            lblCustInfo.Text = "Order History for: " + cust.getCustomerNameScalar("GROSR");
        }
    }
}
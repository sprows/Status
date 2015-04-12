using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SC
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DBData info = new DBData();
            string temp = info.GetStatusCount("123");
            Response.Write("Before Insert");

            string ID = info.InsertComment("hi",2,DateTime.Now,"123", "Tom","456",777);

            Response.Write("After Insert");
            Response.Write(ID);
        }
    }
}
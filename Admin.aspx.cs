using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SC
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                LogonPanel.Visible = true;
                GridPanel.Visible = false;
            }

            if (GridPanel.Visible)
            {
                DBData info = new DBData();
                AdminGridview.DataSource = info.GetStatusStats();
                AdminGridview.DataBind();
            }

        }

        private string ConvertSortDirectionToSql(SortDirection sortDirection)
        {
            string newSortDirection = String.Empty;

            switch (sortDirection)
            {
                case SortDirection.Ascending:
                    newSortDirection = "ASC";
                    break;

                case SortDirection.Descending:
                    newSortDirection = "DESC";
                    break;
            }

            return newSortDirection;
        }

        protected void gridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            AdminGridview.PageIndex = e.NewPageIndex;
            AdminGridview.DataBind();
        }

        protected void gridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataSet dataT = AdminGridview.DataSource as DataSet;

            if (dataT.Tables[0] != null)
            {

                DataView dataView = new DataView(dataT.Tables[0]);
                dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

                AdminGridview.DataSource = dataView;
                AdminGridview.DataBind();
            }
        }

        protected void LogonButton_Click(object sender, EventArgs e)
        {
            if (passwordText.Text == "tomrocks")
            {
                LogonPanel.Visible = false;
                GridPanel.Visible = true;

                DBData info = new DBData();

                AdminGridview.DataSource = info.GetStatusStats();
                AdminGridview.DataBind();
            }
        }
    }
}
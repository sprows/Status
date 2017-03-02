using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TheArtOfDev.HtmlRenderer;

namespace SC
{
    public partial class mystats : System.Web.UI.Page
    {

        private static readonly Object obj = new Object();

        protected void Page_Load(object sender, EventArgs e)
        {
            string posts = "";
            string likes = "";
            string comments = "";
            string id = "";
            string payload = "";
            string typ = "";
            string Title = "";

            if (Request.QueryString["g"] == "good")
            {
                if (Request.QueryString["p"] != null)
                {
                    posts = Request.QueryString["p"];
                }

                if (Request.QueryString["l"] != null)
                {
                    likes = Request.QueryString["l"];
                }

                if (Request.QueryString["c"] != null)
                {
                    comments = Request.QueryString["c"];
                }

                if (Request.QueryString["id"] != null)
                {
                    id = Request.QueryString["id"];
                }

                if (Request.QueryString["pl"] != null)
                {
                    payload = Request.QueryString["pl"];
                }

                if (Request.QueryString["typ"] != null)
                {
                    typ = Request.QueryString["typ"];
                }

                if (Request.QueryString["ti"] != null)
                {
                    Title = Request.QueryString["ti"];
                }

                DBData db = new DBData();

                if (payload.Length > 0)
                {
                    CreateImage(payload, typ, Title);
                }
                else
                {
                        try
                        {
                            db.InsertStatusStats(id, Convert.ToInt32(likes), Convert.ToInt32(comments), Convert.ToInt32(posts));
                        }
                        catch (Exception ex)
                        {
                            //Ignore
                        }
                }
            }

        }

        private void CreateImage(string payload, string action, string title)
        {

            //payload = "Tom Sprows,51,767233921*Marybeth Sprows,38,10152123937748549*Linda Rezer Halverson,33,10202783779373385*Kimberly Murphy Marusco,24,10203686889794315";

            int i = 1;
            Guid imageName = Guid.NewGuid();
            string html = "<table width ='605'><tr><td colspan='2'><div align='center'><h2>My top 10 most " + action + " statuses</h2></div></td></tr>";
            string table1 = "";
            string table2 = "";

            string[] Names = payload.Split('*');
            foreach (var c in Names)
            {
                
                string[] NameBundle = c.Split(',');

                if (i< 6)
                {
                    table1 += "<tr><td align='right'><img height='45' width='45' src='http://graph.facebook.com/" + NameBundle[2] + "/picture?type=normal'></td>";
                    table1 += "<td><b>#" + i + "</b> " + NameBundle[0] + " <span style='font-weight: bold;'>" + NameBundle[1] + "</span> times</td></tr>";
                   
                }
                else
                {
                    table2 += "<tr><td align='right'><img height='45' width='45' src='http://graph.facebook.com/" + NameBundle[2] + "/picture?type=normal'></td>";
                    table2 += "<td><b>#" + i + "</b> " + NameBundle[0] + " <span style='font-weight: bold;'>" + NameBundle[1] + "</span> times</td></tr>";

                }

                i += 1;
            }

            table1 = "<table>" + table1 + "</table>";
            table2 = "<table>" + table2 + "</table>";

            html += "<tr><td>" + table1 + "</td><td>" + table2 + "</td></tr></table>";

            lock (obj) { 
                using (System.Drawing.Image image = TheArtOfDev.HtmlRenderer.WinForms.HtmlRender.RenderToImageGdiPlus(html))
                {
                    string path = HttpContext.Current.Server.MapPath("~/cdn/" + imageName + ".png");
                    image.Save(path, ImageFormat.Png);
                }
            }

            Response.Clear();
            Response.ContentType = "text/plain";
            Response.Write(imageName + ".png");
            Response.End();
           

        }
    }
}
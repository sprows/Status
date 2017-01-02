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
    public partial class mobile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            System.Drawing.Image image = TheArtOfDev.HtmlRenderer.WinForms.HtmlRender.RenderToImageGdiPlus("<table><tr><td></td><td><div align='center'>My Top 10 Commenters</div></td></tr><tr><td><img height='35' width='35' style='vertical-align:middle;' src='http://graph.facebook.com/767233921/picture?type=normal'></td><td><b>#1</b> Tom Sprows commented <span style='font-weight: bold;'>43</span> times</td></tr><tr><td><img height='35' width='35' style='vertical-align:middle;' src='http://graph.facebook.com/10202685244110065/picture?type=normal'></td><td style='background-color: #F0F0F0'><b>#2</b> Linda Rezer Halvorsen commented <span style='font-weight: bold;'>32</span> times</td></tr><tr><td><img height='35' width='35' style='vertical-align:middle;' src='http://graph.facebook.com/10152805432443549/picture?type=normal'></td><td><b>#3</b> Marybeth Sprows commented <span style='font-weight: bold;'>31</span> times</td></tr></table>");
            image.Save(@"C:\sprows\imagecreator\ImageCreator\Test.png", ImageFormat.Png);

        }
    }
}
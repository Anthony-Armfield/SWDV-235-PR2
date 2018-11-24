using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWDV_PR2
{
    public partial class borrower : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //Submit Button to submit and clear form
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "Thank you for submitting your info.";
            txtFName.Text = "";
            txtLName.Text = "";
            txtPhone.Text = "";
        }

        //Clear button to clear all fields and message field
        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtFName.Text = "";
            txtLName.Text = "";
            txtPhone.Text = "";
            lblMessage.Text = "";
        }
    }
}
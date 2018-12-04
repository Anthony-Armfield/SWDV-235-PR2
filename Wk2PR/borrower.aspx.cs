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
        protected void gvBorrowers_PreRender(object sender, EventArgs e)
        {
            gvBorrowers.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void gvBorrowers_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblError.Text = ConcurrencyErrorMessage();
            }
        }

        protected void gvBorrowers_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblError.Text = ConcurrencyErrorMessage();
            }
        }
        //Submit Button to submit and clear form
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var parameters = insertBorrowerForm.InsertParameters;
                parameters["borrower_first_name"].DefaultValue = txtFirstName.Text;
                parameters["borrower_last_name"].DefaultValue = txtLastName.Text;
                parameters["borrower_phone_number"].DefaultValue = txtPhoneNumber.Text;

                try
                {
                    insertBorrowerForm.Insert();
                    txtFirstName.Text = "";
                    txtLastName.Text = "";
                    txtPhoneNumber.Text = "";
                    gvBorrowers.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = DatabaseErrorMessage(ex.Message);
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtPhoneNumber.Text = "";
        }
        private string DatabaseErrorMessage(string errorMsg)
        {
            return $"<b>A database error has occurred:</b> {errorMsg}";
        }
        private string ConcurrencyErrorMessage()
        {
            return "Another user may have updated that artist. Please try again";
        }
    }
}
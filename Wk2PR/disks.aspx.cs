using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWDV_PR2
{
    public partial class disks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void gvDisks_PreRender(object sender, EventArgs e)
        {
            gvDisks.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void gvDisks_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {

        }

        protected void gvDisks_RowDeleted(object sender, GridViewDeletedEventArgs e)
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
        private string DatabaseErrorMessage(string errorMsg)
        {
            return $"<b>A database error has occurred:</b> {errorMsg}";
        }
        private string ConcurrencyErrorMessage()
        {
            return "Another user may have updated that artist. Please try again";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                var parameters = insertDiskForm.InsertParameters;
                parameters["disk_name"].DefaultValue = txtDiskName.Text;
                parameters["genre"].DefaultValue = txtDiskGenre.Text;
                parameters["release_date"].DefaultValue = txtReleaseDate.Text;
                parameters["disk_type"].DefaultValue = ddlType.SelectedValue;
                parameters["status"].DefaultValue = ddlStatus.SelectedValue;

                try
                {
                    insertDiskForm.Insert();
                    txtDiskName.Text = "";
                    txtDiskGenre.Text = "";
                    txtReleaseDate.Text = "";
                    gvDisks.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = DatabaseErrorMessage(ex.Message);
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtDiskName.Text = "";
            txtDiskGenre.Text = "";
            txtReleaseDate.Text = "";
        }

        protected void btnCheckoutSubmit_Click(object sender, EventArgs e)
        {
                if (IsValid)
                {
                    var parameters = dsCheckoutSubmit.InsertParameters;
                    parameters["disk_name"].DefaultValue = ddlCheckoutDisk.SelectedValue;
                    parameters["borrowerName"].DefaultValue = ddlCheckoutBorrower.SelectedValue;
                    parameters["borrowed_date"].DefaultValue = txtCheckoutDate.Text;

                    try
                    {
                        dsCheckoutSubmit.Insert();
                        grReport.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = DatabaseErrorMessage(ex.Message);
                    }
                }
        }
    }
}
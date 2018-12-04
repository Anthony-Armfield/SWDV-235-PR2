using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SWDV_PR2
{
    public partial class artists : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gvArtists_PreRender(object sender, EventArgs e)
        {
            gvArtists.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void gvArtists_RowDeleted(object sender, GridViewDeletedEventArgs e)
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

        protected void gvArtists_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = DatabaseErrorMessage(e.Exception.Message);
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
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
                var parameters = insertArtistInfo.InsertParameters;
                parameters["ArtistFName"].DefaultValue = txtartistFirstName.Text;
                parameters["ArtistLName"].DefaultValue = txtartistLastName.Text;
                parameters["ArtistBand"].DefaultValue = txtBandName.Text;
                parameters["artistType"].DefaultValue = ddlType.SelectedValue;

                try
                {
                    insertArtistInfo.Insert();
                    txtartistFirstName.Text = "";
                    txtartistLastName.Text = "";
                    txtBandName.Text = "";
                    gvArtists.DataBind();
                }
                catch (Exception ex)
                {
                    lblError.Text = DatabaseErrorMessage(ex.Message);
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtartistFirstName.Text = "";
            txtartistLastName.Text = "";
            txtBandName.Text = "";
        }
    }
}
<%@ Page Language="C#" Title="Borrower Information" MasterPageFile="~/diskInventory.Master" AutoEventWireup="true" CodeBehind="borrower.aspx.cs" Inherits="SWDV_PR2.borrower" %>
<%@ MasterType VirtualPath="~/diskInventory.Master" %>

<asp:Content ID="borrowerInfo" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="row">
        <div class="col-sm-12">
            <div class="form-group">
                <h1>Borrower Information:</h1>
                <!-- validation summary for error messages -->
                <asp:ValidationSummary ID="vsBorrowerInfo" runat="server" CssClass="text-danger" HeaderText="Please fix the following errors:" />
                <!-- start of borrower information text boxes -->
                <asp:Label CssClass="col-sm-3 control-label" ID="lblFName" runat="server" Text="First Name"></asp:Label>
                <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvFName"
                    runat="server" 
                    ErrorMessage="First Name is Required"
                    ControlToValidate="txtFName"
                    CssClass="text-danger" Text="*"></asp:RequiredFieldValidator>
                <br />
                <asp:Label CssClass="col-sm-3 control-label" ID="lblLName" runat="server" Text="Last Name"></asp:Label>
                <asp:TextBox ID="txtLName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvLName"
                    runat="server"
                    ErrorMessage="Last Name is Required"
                    ControlToValidate="txtLName"
                    CssClass="text-danger" Text="*"></asp:RequiredFieldValidator>
                <br />
                <asp:Label CssClass="col-sm-3 control-label" ID="lblPhone" runat="server" Text="Phone Number"></asp:Label>
                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvPhone"
                    runat="server"
                    ErrorMessage="Phone Number is Required"
                    ControlToValidate="txtPhone"
                    CssClass="text-danger" Text="*"></asp:RequiredFieldValidator>
                <br />
                <!-- submit and clear buttons -->
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CausesValidation="False" />
                <br />
                <!-- message for when the info is submitted successfully -->
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
<%@ Page Language="C#" Title="Borrower Information" MasterPageFile="~/diskInventory.Master" AutoEventWireup="true" CodeBehind="borrower.aspx.cs" Inherits="SWDV_PR2.borrower" %>
<%@ MasterType VirtualPath="~/diskInventory.Master" %>

<asp:Content ID="borrowers" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="row">
        <div class="col-sm-12 text-center">
            <h4>Below is a list of borrowers and their phone numbers. </h4>
        </div>
        <div class="col-sm-12 table-responsive">
            <!-- Display the disk data currently in the table -->
            <asp:GridView ID="gvBorrowers"
                runat="server"
                AllowPaging="True"
                AllowSorting="True"
                AutoGenerateColumns="False"
                DataSourceID="gridBorrowers"
                DataKeyNames="borrower_ID"
                CssClass="table table-bordered table-condensed table-hover"
                OnPreRender="gvBorrowers_PreRender"
                OnRowDeleted="gvBorrowers_RowDeleted"
                OnRowUpdated="gvBorrowers_RowUpdated">
                <Columns>
                    <asp:BoundField DataField="borrower_ID" HeaderText="borrower_ID" 
                        SortExpression="borrower_ID" ItemStyle-CssClass="col-xs-2" InsertVisible="False" ReadOnly="True" Visible="False">
                    </asp:BoundField>
                    <asp:BoundField DataField="borrower_first_name" HeaderText="First Name" 
                        SortExpression="borrower_first_name" ItemStyle-CssClass="col-xs-2">
                    </asp:BoundField>
                    <asp:BoundField DataField="borrower_last_name" HeaderText="Last Name" 
                        SortExpression="borrower_last_name" ItemStyle-CssClass="col-xs-2" >
                    </asp:BoundField>
                    <asp:BoundField DataField="borrower_phone_number" HeaderText="Phone Number" 
                        SortExpression="borrower_phone_number" ItemStyle-CssClass="col-xs-2" >
                    </asp:BoundField>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
                <HeaderStyle CssClass="bg-halloween" />
                <AlternatingRowStyle CssClass="altRow" />
                <PagerSettings Mode="NumericFirstLast" />
                <PagerStyle CssClass="pagerStyle" BackColor="#a8c8c8c" HorizontalAlign="Center" />
                <EditRowStyle CssClass="warning" />
            </asp:GridView>
            <asp:SqlDataSource ID="gridBorrowers"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                SelectCommand="SELECT [borrower_ID],
                    [borrower_first_name],
                    [borrower_last_name],
                    [borrower_phone_number]
                FROM [BorrowerInfo]
                ORDER BY [borrower_last_name]"
                DeleteCommand="sp_DeleteBorrowerInfo"
                DeleteCommandType="StoredProcedure"
                UpdateCommand="sp_UpdateBorrowerName"
                UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="borrower_ID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="borrower_ID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="borrower_first_name" Type="string"></asp:Parameter>
                    <asp:Parameter Name="borrower_last_name" Type="string"></asp:Parameter>
                    <asp:Parameter Name="borrower_phone_number" Type="string"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </div>
        <!-- Form to add, update, delete borrowers -->
        <div class="form-group col-sm-12">
            <div class="col-sm-3"></div>
            <div class="col-sm-6">
                <h4>Want to become a borrower? Fill out the form below.</h4>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please correct these entries:" CssClass="text-danger"/>
                <label class="col-sm-3 control-label">First Name</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBorrowerFirstName"
                        runat="server"
                        ControlToValidate="txtFirstName"
                        Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="First Name">First name is required.</asp:RequiredFieldValidator>
                </div>
                <!-- insert validators here -->
                <label class="col-sm-3 control-label">Last Name</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBorrowerLastName"
                        runat="server"
                        ControlToValidate="txtLastName"
                        Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="Last Name">Last name is required.</asp:RequiredFieldValidator>
                </div>
                <!-- insert validators here -->
                <label class="col-sm-3 control-label">Phone Number</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBorrowerPhone"
                        runat="server"
                        ControlToValidate="txtPhoneNumber"
                        Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="Phone Number">Phone number is required.</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPhoneNumber"
                        runat="server"
                        ErrorMessage="Phone number must be in this format: (123)-456-7890"
                        ValidationExpression="^([0-9\(\)\/\+ \-]*)$"
                        ControlToValidate="txtPhoneNumber"
                        CssClass="text-danger"></asp:RegularExpressionValidator>
                </div>

                <%-- Submit and Clear buttons --%>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                                CssClass="btn btn-primary" OnClick="btnSubmit_Click"  />
                        <asp:SqlDataSource ID="insertBorrowerForm"
                            runat="server"
                            ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                            ConflictDetection="CompareAllValues" 
                            InsertCommand="sp_InsertBorrowerInfo"
                            InsertCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="borrower_first_name"></asp:Parameter>
                                <asp:Parameter Name="borrower_last_name"></asp:Parameter>
                                <asp:Parameter Name="borrower_phone_number"></asp:Parameter>
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false"  />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
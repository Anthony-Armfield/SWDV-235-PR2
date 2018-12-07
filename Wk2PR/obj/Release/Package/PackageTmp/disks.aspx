<%@ Page Language="C#" Title="" MasterPageFile="~/diskInventory.Master" AutoEventWireup="true" CodeBehind="disks.aspx.cs" Inherits="SWDV_PR2.disks" %>

<%@ MasterType VirtualPath="~/diskInventory.Master" %>

<asp:Content ID="disks" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="row">
        <div class="col-sm-12 text-center">
            <h4>Below is a list of disks, their details, and their status in the inventory. </h4>
        </div>
        <div class="col-sm-12 table-responsive">
            <!-- Display the disk data currently in the table -->
            <asp:GridView ID="gvDisks"
                runat="server"
                AllowPaging="True"
                AllowSorting="True"
                AutoGenerateColumns="False"
                DataSourceID="gridView_Disks"
                DataKeyNames="disk_ID"
                CssClass="table table-bordered table-condensed table-hover"
                OnPreRender="gvDisks_PreRender"
                OnRowDeleted="gvDisks_RowDeleted"
                OnRowUpdated="gvDisks_RowUpdated">
                <Columns>
                    <asp:BoundField DataField="disk_ID" HeaderText="disk_ID" 
                        SortExpression="disk_ID" ItemStyle-CssClass="col-xs-2" InsertVisible="False" ReadOnly="True" Visible="False">
                        <ItemStyle CssClass="col-xs-2"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="disk_name" HeaderText="Disk Name" 
                        SortExpression="disk_name" ItemStyle-CssClass="col-xs-2" >
                        <ItemStyle CssClass="col-xs-2"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="genre" HeaderText="Genre" 
                        SortExpression="genre" ItemStyle-CssClass="col-xs-2" >
                        <ItemStyle CssClass="col-xs-2"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="release_date" HeaderText="Release Date" 
                        SortExpression="release_date" ItemStyle-CssClass="col-xs-2" >
                        <ItemStyle CssClass="col-xs-2"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="disk_type" HeaderText="Type" 
                        SortExpression="disk_type" ItemStyle-CssClass="col-xs-2" >
                        <ItemStyle CssClass="col-xs-2"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="status" HeaderText="Status" 
                        SortExpression="status" ItemStyle-CssClass="col-xs-2">
                        <ItemStyle CssClass="col-xs-2"></ItemStyle>
                    </asp:BoundField>
                    <asp:CommandField ShowEditButton="True" CausesValidation="False" />
                    <asp:CommandField ShowDeleteButton="True" />
                </Columns>
                <HeaderStyle CssClass="bg-halloween" />
                <AlternatingRowStyle CssClass="altRow" />
                <PagerSettings Mode="NumericFirstLast" />
                <PagerStyle CssClass="pagerStyle" BackColor="#a8c8c8c" HorizontalAlign="Center" />
                <EditRowStyle CssClass="warning" />
            </asp:GridView>
            <asp:SqlDataSource 
                ID="gridView_Disks" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                SelectCommand="SELECT [Disk].disk_ID, [Disk].disk_name, [Disk].genre, [Disk].release_date, [Disk].disk_type, Status.status FROM [Disk] INNER JOIN Status ON [Disk].status_ID = Status.status_ID ORDER BY [Disk].disk_name"
                DeleteCommand="sp_DeleteDisk"
                DeleteCommandType="StoredProcedure"
                UpdateCommand="sp_UpdateDisk"
                UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="disk_ID" Type="Int16"></asp:Parameter>
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="disk_ID" Type="int16"></asp:Parameter>
                    <asp:Parameter Name="disk_name" Type="string"></asp:Parameter>
                    <asp:Parameter Name="genre" Type="string"></asp:Parameter>
                    <asp:Parameter Name="release_date" Type="datetime"></asp:Parameter>
                    <asp:Parameter Name="disk_type" Type="string"></asp:Parameter>
                    <asp:Parameter Name="status" Type="string"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </div>
        <!-- Form to add, update, delete disks -->
        <div class="form-group col-sm-6">
            <h3>To enter a new disk, fill out the form below.</h3>
            <asp:ValidationSummary ID="vsInsertDisk" runat="server" HeaderText="Please correct these entries:" CssClass="text-danger" ValidationGroup="diskInsert" />
            <div class="row">
                <label class="col-sm-4 control-label">Disk Name</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtDiskName" runat="server" CssClass="form-control"></asp:TextBox>
                    <!-- insert validators here -->
                    <asp:RequiredFieldValidator ID="rfvDiskName" runat="server" ErrorMessage="Disk Name" ControlToValidate="txtDiskName" Display="Dynamic" CssClass="text-danger" ValidationGroup="diskInsert">Disk name is required.</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Disk Genre</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtDiskGenre" runat="server" CssClass="form-control"></asp:TextBox>
                    <!-- insert validators here -->
                    <asp:RequiredFieldValidator ID="rfvDiskGenre" runat="server" ErrorMessage="Disk Genre" ControlToValidate="txtDiskGenre" Display="Dynamic" CssClass="text-danger" ValidationGroup="diskInsert">Disk genre is required.</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Release Date</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtReleaseDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    <!-- insert validators here -->
                    <asp:RequiredFieldValidator ID="rfvReleaseDate" runat="server" ErrorMessage="Release Date" ControlToValidate="txtReleaseDate" Display="Dynamic" CssClass="text-danger" ValidationGroup="diskInsert">Release date is required.</asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Disk Type</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                        <asp:ListItem>CD</asp:ListItem>
                        <asp:ListItem>DVD</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Status</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" DataSourceID="sdsSelectStatus" DataTextField="status" DataValueField="status"></asp:DropDownList>
                    <asp:SqlDataSource ID="sdsSelectStatus"
                        runat="server"
                        ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                        SelectCommand="SELECT [status] FROM [Status]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="row">
                <%-- Submit and Clear buttons --%>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                                CssClass="btn btn-primary" OnClick="btnSubmit_Click"  />
                        <asp:SqlDataSource ID="insertDiskForm"
                            runat="server"
                            ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                            ConflictDetection="CompareAllValues" 
                            InsertCommand="sp_InsertDiskInfo"
                            InsertCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="disk_name"></asp:Parameter>
                                <asp:Parameter Name="genre"></asp:Parameter>
                                <asp:Parameter Name="release_date"></asp:Parameter>
                                <asp:Parameter Name="disk_type"></asp:Parameter>
                                <asp:Parameter Name="status"></asp:Parameter>
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:Button ID="btnClear" runat="server" Text="Clear"
                            CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false"  />
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group col-sm-6">
            <h3>To check out a disk, fill out the form below.</h3>
            <asp:ValidationSummary ID="vsCheckout" runat="server" HeaderText="Please correct these entries:" CssClass="text-danger"/>
            <div class="row">
                <label class="col-sm-4 control-label">Disk Name</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="ddlCheckoutDisk" runat="server" DataSourceID="ddlDiskSelection" DataTextField="disk_name" DataValueField="disk_name"></asp:DropDownList>
                    <asp:SqlDataSource ID="ddlDiskSelection"
                        runat="server"
                        ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                        SelectCommand="SELECT [disk_name] FROM [Disk]"></asp:SqlDataSource>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Borrower's First Name</label>
                <div class="col-sm-8">
                    <asp:DropDownList ID="ddlCheckoutBorrower" runat="server" DataSourceID="ddlBorrowerName" DataTextField="BorrowerName" DataValueField="BorrowerName"></asp:DropDownList>
                    <asp:SqlDataSource ID="ddlBorrowerName"
                        runat="server"
                        ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                        SelectCommand="sp_BorrowerNameCombo"
                        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                </div>
            </div>
            <div class="row">
                <label class="col-sm-4 control-label">Checked Out</label>
                <div class="col-sm-8">
                    <asp:TextBox ID="txtCheckoutDate"
                        runat="server"
                        CssClass="form-control"
                        TextMode="Date"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <%-- Submit and Clear buttons --%>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <asp:Button ID="btnCheckoutSubmit" runat="server" Text="Submit"
                                CssClass="btn btn-primary" OnClick="btnCheckoutSubmit_Click"/>
                        <asp:SqlDataSource ID="dsCheckoutSubmit"
                            runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                            InsertCommand="sp_CheckoutDisk"
                            InsertCommandType="StoredProcedure"
                            SelectCommand="SELECT [Disk].disk_ID,
                                [Disk].status_ID,
                                DiskHasBorrower.borrowed_date,
                                DiskHasBorrower.borrower_ID,
                                DiskHasBorrower.disk_ID
                            FROM [Disk]
                            INNER JOIN DiskHasBorrower
                                ON [Disk].disk_ID = DiskHasBorrower.disk_ID
                            INNER JOIN Status
                                ON [Disk].status_ID = Status.status_ID">
                            <InsertParameters>
                                <asp:Parameter Name="disk_name" Type="String"/>
                                <asp:Parameter Name="borrowerName" Type="String"/>
                                <asp:Parameter Name="borrowed_date" Type="DateTime"/>
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:Button ID="Button2" runat="server" Text="Clear"
                            CssClass="btn btn-primary" OnClick="btnClear_Click" CausesValidation="false"  />
                    </div>
                </div>
            </div>
        </div>
                <div class="col-sm-12 table-responsive">
            <!-- Display the disk data currently in the table -->
            <asp:GridView ID="grReport"
                runat="server"
                AllowPaging="True"
                AllowSorting="True"
                AutoGenerateColumns="False"
                DataSourceID="gridCheckedOutReport"
                CssClass="table table-bordered table-condensed table-hover"
                OnPreRender="gvDisks_PreRender"
                OnRowDeleted="gvDisks_RowDeleted"
                OnRowUpdated="gvDisks_RowUpdated">
                <Columns>
                    <asp:BoundField DataField="disk_name" HeaderText="Disk Name" 
                        SortExpression="disk_name" ItemStyle-CssClass="col-xs-2">
                    </asp:BoundField>
                    <asp:BoundField DataField="borrowed_date" HeaderText="Borrowed Date" 
                        SortExpression="borrowed_date" ItemStyle-CssClass="col-xs-2" >
                    </asp:BoundField>
                    <asp:BoundField DataField="borrower_first_name" HeaderText="Borrower First Name" 
                        SortExpression="borrower_first_name" ItemStyle-CssClass="col-xs-2" >
                    </asp:BoundField>
                    <asp:BoundField DataField="borrower_last_name" HeaderText="Borrower Last Name" 
                        SortExpression="borrower_last_name" ItemStyle-CssClass="col-xs-2" >
                    </asp:BoundField>
                    <asp:BoundField DataField="status" HeaderText="Status" 
                        SortExpression="status" ItemStyle-CssClass="col-xs-2" >
                    </asp:BoundField>
                </Columns>
                <HeaderStyle CssClass="bg-halloween" />
                <AlternatingRowStyle CssClass="altRow" />
                <PagerSettings Mode="NumericFirstLast" />
                <PagerStyle CssClass="pagerStyle" BackColor="#a8c8c8c" HorizontalAlign="Center" />
                <EditRowStyle CssClass="warning" />
            </asp:GridView>
                    <asp:SqlDataSource ID="gridCheckedOutReport" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>" SelectCommand="SELECT [Disk].disk_name, DiskHasBorrower.borrowed_date, BorrowerInfo.borrower_first_name, BorrowerInfo.borrower_last_name, Status.status FROM DiskHasBorrower INNER JOIN BorrowerInfo ON DiskHasBorrower.borrower_ID = BorrowerInfo.borrower_ID INNER JOIN [Disk] ON DiskHasBorrower.disk_ID = [Disk].disk_ID INNER JOIN Status ON [Disk].status_ID = Status.status_ID WHERE (Status.status_ID = 1)"></asp:SqlDataSource>
            <asp:SqlDataSource 
                ID="SqlDataSource1" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                SelectCommand="SELECT [Disk].disk_ID, [Disk].disk_name, [Disk].genre, [Disk].release_date, [Disk].disk_type, Status.status FROM [Disk] INNER JOIN Status ON [Disk].status_ID = Status.status_ID ORDER BY [Disk].disk_name"
                DeleteCommand="sp_DeleteDisk"
                DeleteCommandType="StoredProcedure"
                UpdateCommand="sp_UpdateDisk"
                UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="disk_ID" Type="Int16"></asp:Parameter>
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="disk_ID" Type="int16"></asp:Parameter>
                    <asp:Parameter Name="disk_name" Type="string"></asp:Parameter>
                    <asp:Parameter Name="genre" Type="string"></asp:Parameter>
                    <asp:Parameter Name="release_date" Type="datetime"></asp:Parameter>
                    <asp:Parameter Name="disk_type" Type="string"></asp:Parameter>
                    <asp:Parameter Name="status" Type="string"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </div>
    </div>
</asp:Content>
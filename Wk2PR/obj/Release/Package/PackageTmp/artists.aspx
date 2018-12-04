<%@ Page Language="C#" Title="" MasterPageFile="~/diskInventory.Master" AutoEventWireup="true" CodeBehind="artists.aspx.cs" Inherits="SWDV_PR2.artists" %>

<%@ MasterType VirtualPath="~/diskInventory.Master" %>

<asp:Content ID="artists" ContentPlaceHolderID="mainPlaceholder" runat="server">
    <div class="row">
        <div class="col-sm-12 text-center">
            <h1>Below is a list of Artists and their bands.</h1>
        </div>
        <div class="col-sm-12 table-responsive">
            <!-- Display the artist data currently in the table -->
            <asp:GridView ID="gvArtists"
                runat="server"
                AllowPaging="True"
                AllowSorting="True"
                AutoGenerateColumns="False"
                DataSourceID="gridView_Artists"
                DataKeyNames="artist_ID"
                CssClass="table table-bordered table-condensed table-hover"
                OnPreRender="gvArtists_PreRender"
                OnRowDeleted="gvArtists_RowDeleted"
                OnRowUpdated="gvArtists_RowUpdated"
                AutoPostBack="True">
                <Columns>
                    <asp:BoundField DataField="artist_ID" HeaderText="Artist ID" 
                        SortExpression="artist_ID" ItemStyle-CssClass="col-xs-2" InsertVisible="False" ReadOnly="True" Visible="False" >
                    </asp:BoundField>
                    <asp:BoundField DataField="artist_FirstName" HeaderText="First Name" 
                        SortExpression="artist_FirstName" ItemStyle-CssClass="col-xs-3" >
                    </asp:BoundField>
                    <asp:BoundField DataField="artist_LastName" HeaderText="Last Name" 
                        SortExpression="artist_LastName" ItemStyle-CssClass="col-xs-3" >
                    </asp:BoundField>
                    <asp:BoundField DataField="artist_band" HeaderText="Band" 
                        SortExpression="artist_band" ItemStyle-CssClass="col-xs-3" >
                    </asp:BoundField>
                    <asp:BoundField DataField="artist_type" HeaderText="Type" 
                        SortExpression="artist_type" ItemStyle-CssClass="col-xs-3" >
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
            <asp:SqlDataSource 
                ID="gridView_Artists" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                SelectCommand="SELECT [artist_ID],
                    [artist_FirstName],
                    [artist_LastName],
                    [artist_band],
                    [artist_type]
                FROM [ArtistInfo]
                ORDER BY [artist_LastName]"
                DeleteCommand="sp_DeleteArtistInfo"
                DeleteCommandType="StoredProcedure"
                UpdateCommand="sp_UpdateArtistInfo"
                UpdateCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:Parameter Name="artist_ID" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="artist_ID" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="artist_FirstName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="artist_LastName" Type="String"></asp:Parameter>
                    <asp:Parameter Name="artist_band" Type="String"></asp:Parameter>
                    <asp:Parameter Name="artist_type" Type="String"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblError" runat="server"></asp:Label>
        </div>
        <!-- Form to add, update, delete artists -->
        <div class="form-group col-sm-12">
            <div class="col-sm-3"></div>
            <div class="col-sm-6">
                <h4>Want to add a new artist? Fill out the form below.</h4>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Please correct these entries:" CssClass="text-danger"/>
                <label class="col-sm-3 control-label">First Name</label>
                <div class="col-sm-7">
                    <asp:TextBox ID="txtartistFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvArtistFirstName"
                        runat="server"
                        ControlToValidate="txtartistFirstName"
                        Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="First Name">First name is required.</asp:RequiredFieldValidator>
                </div>
                <!-- insert validators here -->
                <label class="col-sm-3 control-label">Last Name</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtartistLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvArtistLastName"
                        runat="server"
                        ControlToValidate="txtartistLastName"
                        Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="Last Name">Last name is required.</asp:RequiredFieldValidator>
                </div>
                <!-- insert validators here -->
                <label class="col-sm-3 control-label">Band Name</label>
                <div class="col-sm-9">
                    <asp:TextBox ID="txtBandName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvArtistBand"
                        runat="server"
                        ControlToValidate="txtBandName"
                        Display="Dynamic"
                        CssClass="text-danger" ErrorMessage="Band Name">Band name is required.</asp:RequiredFieldValidator>
                </div>
                <!-- insert validators here -->
                <label class="col-sm-3 control-label">Artist Type</label>
                <div class="col-sm-9">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                        <asp:ListItem>Band</asp:ListItem>
                        <asp:ListItem>Solo</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <!-- insert validators here -->

                <%-- Submit and Clear buttons --%>
                <div class="form-group">
                    <div class="col-sm-offset-3 col-sm-9">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"
                                CssClass="btn btn-primary" OnClick="btnSubmit_Click"  />
                        <asp:SqlDataSource ID="insertArtistInfo"
                            runat="server"
                            ConnectionString="<%$ ConnectionStrings:disk_inventoryConnectionString %>"
                            InsertCommand="sp_InsertArtistInfo"
                            InsertCommandType="StoredProcedure"
                            SelectCommand="SELECT ArtistInfo.artist_FirstName,
                                ArtistInfo.artist_LastName,
                                ArtistInfo.artist_band,
                                ArtistInfo.artist_type
                            FROM ArtistInfo
                            INNER JOIN DiskHasArtist
                            ON ArtistInfo.artist_ID = DiskHasArtist.artist_ID">
                            <InsertParameters>
                                <asp:Parameter Name="ArtistFName" Type="String" />
                                <asp:Parameter Name="ArtistLName" Type="String" />
                                <asp:Parameter Name="ArtistBand" Type="String" />
                                <asp:Parameter Name="artistType" Type="String" />
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
<%@ Page Title="Employee Area" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admins.aspx.cs" Inherits="NorWinds_V2_Site.Administrators" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <br />
    <br />
    <h4>
        <asp:Label ID="lblMessage" runat="server" Text="Search for pending orders by Date or by Customer"></asp:Label>
    </h4>
    <br />
    <br />

    <div class="row">
        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            Customer:<br />
            <ajaxToolkit:ComboBox ID="cbxCustomer" runat="server" DataSourceID="CustObjDataSrc" DataTextField="CompanyName" DataValueField="CustomerID" MaxLength="0" Style="display: inline;"></ajaxToolkit:ComboBox>
            <asp:ObjectDataSource ID="CustObjDataSrc" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUniqueCustIDS" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.CustomersTableAdapter"></asp:ObjectDataSource>
        </div>

        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            <br />
            <asp:Button ID="btnGetCustOrders" runat="server" Text="Find Orders by Customer" OnClick="btnGetCustOrders_Click"/>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            <br />
            <h4>Or</h4>
            <br />
        </div>
    </div>

    <div class="row">
        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            Date:<br />
            <ajaxToolkit:ComboBox ID="cbxDate" runat="server" DataSourceID="OrderDateObjDataSrc" DataTextField="OrderDate" DataValueField="OrderDate" MaxLength="0" Style="display: inline;"></ajaxToolkit:ComboBox>
            <asp:ObjectDataSource ID="OrderDateObjDataSrc" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUniqueRequiredDates" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.OrdersTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_OrderID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CustomerID" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="Int32" />
                    <asp:Parameter Name="OrderDate" Type="DateTime" />
                    <asp:Parameter Name="RequiredDate" Type="DateTime" />
                    <asp:Parameter Name="ShippedDate" Type="DateTime" />
                    <asp:Parameter Name="ShipVia" Type="Int32" />
                    <asp:Parameter Name="Freight" Type="Decimal" />
                    <asp:Parameter Name="ShipName" Type="String" />
                    <asp:Parameter Name="ShipAddress" Type="String" />
                    <asp:Parameter Name="ShipCity" Type="String" />
                    <asp:Parameter Name="ShipRegion" Type="String" />
                    <asp:Parameter Name="ShipPostalCode" Type="String" />
                    <asp:Parameter Name="ShipCountry" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CustomerID" Type="String" />
                    <asp:Parameter Name="EmployeeID" Type="Int32" />
                    <asp:Parameter Name="OrderDate" Type="DateTime" />
                    <asp:Parameter Name="RequiredDate" Type="DateTime" />
                    <asp:Parameter Name="ShippedDate" Type="DateTime" />
                    <asp:Parameter Name="ShipVia" Type="Int32" />
                    <asp:Parameter Name="Freight" Type="Decimal" />
                    <asp:Parameter Name="ShipName" Type="String" />
                    <asp:Parameter Name="ShipAddress" Type="String" />
                    <asp:Parameter Name="ShipCity" Type="String" />
                    <asp:Parameter Name="ShipRegion" Type="String" />
                    <asp:Parameter Name="ShipPostalCode" Type="String" />
                    <asp:Parameter Name="ShipCountry" Type="String" />
                    <asp:Parameter Name="Original_OrderID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </div>

        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            <br />
            <asp:Button ID="btnGetDateOrders" runat="server" Text="Find Orders by Date" OnClick="btnGetDateOrders_Click"/>
        </div>
        <br />
    </div>

    <div class="row">
        <asp:ListView ID="lsvOrders" runat="server" DataKeyNames="OrderID">
        <AlternatingItemTemplate>
            <div style="background-color: azure;">
                  <br />
                <a href="OrderDetails.aspx?OrderID=<%# Eval("OrderID") %> " class="altPendingBlock">
                            Order ID:
                    <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>' />
                            <br />
                            Order Date:
                    <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate") %>' />
                            <br />
                            Required Date:
                    <asp:Label ID="RequiredDateLabel" runat="server" Text='<%# Eval("RequiredDate") %>' />
                            <br />
                </a>
                <br />
            </div>
        </AlternatingItemTemplate>

        <EmptyDataTemplate>
            <span>No pending orders.</span>
        </EmptyDataTemplate>

        <ItemTemplate>
            <br />
            <a href="OrderDetails.aspx?OrderID=<%# Eval("OrderID") %> ">Order ID:
            <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>' />
                <br />
                Order Date:
            <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate") %>' />
                <br />
                Delivery Date:
            <asp:Label ID="RequiredDateLabel" runat="server" Text='<%# Eval("RequiredDate") %>' />
                <br />
            </a>
            <br />
        </ItemTemplate>

        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
            </div>
        </LayoutTemplate>

    </asp:ListView>
    </div>



</asp:Content>


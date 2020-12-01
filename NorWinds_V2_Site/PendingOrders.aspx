<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PendingOrders.aspx.cs" Inherits="NorWinds_V2_Site.PendingOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <br />
    <asp:Label ID="lblMessage" runat="server" Text="This page would get orders based on login, had I reached that part of the project. For testing it is hardcoded to a single lookup."></asp:Label>
    <br />
    <br />
    <asp:Label ID="lblCustInfo" runat="server" Text="Label"></asp:Label>
    <br />
    <br />
    <asp:ListView ID="lsvOrders" runat="server" DataKeyNames="OrderID" DataSourceID="ordersObjDataSrc">
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
    <asp:ObjectDataSource ID="ordersObjDataSrc" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetOrdersByCustID" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.OrdersTableAdapter" UpdateMethod="Update">
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
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="CustID" Type="String" DefaultValue="" />
        </SelectParameters>
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
</asp:Content>

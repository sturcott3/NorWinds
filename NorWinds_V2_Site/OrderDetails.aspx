<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="NorWinds_V2_Site.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:ListView ID="LsvOrderHeader" runat="server" DataKeyNames="OrderID" DataSourceID="OrderHeaderObjDataSrc">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>Oops, something went wrong.</td>
                </tr>
            </table>
        </EmptyDataTemplate>

        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>' />
                </td>
                <td>
                    <asp:Label ID="CustomerIDLabel" runat="server" Text='<%# Eval("CustomerID") %>' />
                </td>
                <td>
                    <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate") %>' />
                </td>
                <td>
                    <asp:Label ID="RequiredDateLabel" runat="server" Text='<%# Eval("RequiredDate") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                            <tr runat="server" style="">
                                <th runat="server" style="width:150px">OrderID</th>
                                <th runat="server" style="width:100px">CustomerID</th>
                                <th runat="server" style="width:200px">OrderDate</th>
                                <th runat="server" style="width:200px">RequiredDate</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style=""></td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>

    <asp:ObjectDataSource ID="OrderHeaderObjDataSrc" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetOrderHeaderByOrderID" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.OrdersTableAdapter" UpdateMethod="Update">
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
            <asp:QueryStringParameter Name="OrderID" QueryStringField="OrderID" Type="Int32" />
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
    <br />
    <br />
    <asp:ListView ID="LsvOrderDetails" runat="server" DataSourceID="OrderDetailsObjDataSrc">
        <AlternatingItemTemplate>
            <tr style="background-color: azure;">
                <td>
                    <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
                </td>
                <td>
                    <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                </td>
                <td>
                    <asp:Label ID="DiscountLabel" runat="server" Text='<%# Eval("Discount") %>' />
                </td>
                <td>
                    <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# Eval("UnitPrice") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>

        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>This order appears to be empty.</td>
                </tr>
            </table>
        </EmptyDataTemplate>

        <ItemTemplate>
            <tr style="padding-top: 5px;">
                <td>
                    <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
                </td>
                <td>
                    <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                </td>
                <td>
                    <asp:Label ID="DiscountLabel" runat="server" Text='<%# Eval("Discount") %>' />
                </td>
                <td>
                    <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# Eval("UnitPrice") %>' />
                </td>
            </tr>
        </ItemTemplate>

        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                            <tr runat="server" style="">
                                <th runat="server" style="width:300px;">ProductName</th>
                                <th runat="server" style="width:120px;">Quantity</th>
                                <th runat="server" style="width:120px;">Discount</th>
                                <th runat="server" style="width:120px;">UnitPrice</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style=""></td>
                </tr>
            </table>
        </LayoutTemplate>

    </asp:ListView>
    <asp:ObjectDataSource ID="OrderDetailsObjDataSrc" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByOrderID" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.OrderDetailViewTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="OrderID" QueryStringField="OrderID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

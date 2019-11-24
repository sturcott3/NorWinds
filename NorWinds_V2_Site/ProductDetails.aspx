<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="NorWinds_V2_Site.ProductDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .validator-message {
            color: red;
            font-style: italic;
        }
    </style>
    <br />
    <br />
    <%-- <TEMP> --%>
    <asp:Label ID="lblDebug1" runat="server" Text="..."></asp:Label>
    <br />
    <asp:Label ID="lblDebug2" runat="server" Text="..."></asp:Label>
    <br />
    <asp:Label ID="lblDebug3" runat="server" Text="..."></asp:Label>
    <br />
    <br />
    <%-- </TEMP> --%>


    <asp:ListView ID="lsvProdDetails" runat="server" DataKeyNames="ProductID" DataSourceID="ProductObjDataSrc">

        <EmptyDataTemplate>
            <span>
                <h4>Oops. Something went wrong. Please contact your System Administrator.</h4>
            </span>
        </EmptyDataTemplate>

        <ItemTemplate>
            <br />
            <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
            <br />
            Product ID:
            <asp:Label ID="ProductIDLabel" runat="server" Text='<%# Eval("ProductID") %>' />
            <br />
            Quantity per Unit:
            <asp:Label ID="QuantityPerUnitLabel" runat="server" Text='<%# Eval("QuantityPerUnit") %>' />
            <br />
            Unit Price:
            <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# Eval("UnitPrice") %>' />
            <br />
            In Stock:
            <asp:Label ID="UnitsInStockLabel" runat="server" Text='<%# Eval("UnitsInStock") %>' />
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

    <asp:ObjectDataSource ID="ProductObjDataSrc" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByProdID" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.ProductsTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_ProductID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProductName" Type="String" />
            <asp:Parameter Name="SupplierID" Type="Int32" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
            <asp:Parameter Name="QuantityPerUnit" Type="String" />
            <asp:Parameter Name="UnitPrice" Type="Decimal" />
            <asp:Parameter Name="UnitsInStock" Type="Int16" />
            <asp:Parameter Name="UnitsOnOrder" Type="Int16" />
            <asp:Parameter Name="ReorderLevel" Type="Int16" />
            <asp:Parameter Name="Discontinued" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="ProdID" QueryStringField="ProdID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ProductName" Type="String" />
            <asp:Parameter Name="SupplierID" Type="Int32" />
            <asp:Parameter Name="CategoryID" Type="Int32" />
            <asp:Parameter Name="QuantityPerUnit" Type="String" />
            <asp:Parameter Name="UnitPrice" Type="Decimal" />
            <asp:Parameter Name="UnitsInStock" Type="Int16" />
            <asp:Parameter Name="UnitsOnOrder" Type="Int16" />
            <asp:Parameter Name="ReorderLevel" Type="Int16" />
            <asp:Parameter Name="Discontinued" Type="Boolean" />
            <asp:Parameter Name="Original_ProductID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>

    <div class="container-fluid ">
        <br />
        <br />
        <div class="row">
            <div class="col-lg-2 col-md-3 col-xs-6">
                Quantity:&nbsp;&nbsp;
                <ajaxToolkit:ComboBox ID="cbxQuantity" runat="server" Width="25px">
                    <asp:ListItem Value="0">...</asp:ListItem>
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                </ajaxToolkit:ComboBox>
                <asp:RangeValidator ID="vldQuantity" runat="server" Text="*   Not enough units in stock." ControlToValidate="cbxQuantity" MinimumValue="1" MaximumValue='99' CssClass="validator-message"> </asp:RangeValidator>
            </div>

            <div class="col-lg-2 col-md-3 col-xs-6">
                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" />
            </div>
        </div>

    </div>
</asp:Content>

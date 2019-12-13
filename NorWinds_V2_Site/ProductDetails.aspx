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
    <h3><%:Title %>: </h3>
    <br />


   <asp:ListView ID="lsvNavCategories" class="center-block" runat="server" DataKeyNames="CategoryID" DataSourceID="CatObjDataSrc">
        
       <ItemTemplate>
            <td runat="server" style="">
                <a href="ShopCategory.aspx?CatID=<%# Eval("CategoryID") %>">
                    <asp:Label ID="CategoryNameLabel" runat="server" Text='<%# Eval("CategoryName") %>' />
                </a>
            </td>
        </ItemTemplate>

        <ItemSeparatorTemplate>
            <td runat="server" class="separator">&nbsp;&nbsp; | &nbsp;&nbsp;
            </td>
        </ItemSeparatorTemplate>

        <LayoutTemplate>
            <table runat="server" border="0" style="">
                <tr id="itemPlaceholderContainer" runat="server">
                    <td id="itemPlaceholder" runat="server"></td>
                </tr>
            </table>
            <div style="">
            </div>
        </LayoutTemplate>
    </asp:ListView>

    <asp:ObjectDataSource ID="CatObjDataSrc" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.CategoriesTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_CategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CategoryName" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CategoryName" Type="String" />
            <asp:Parameter Name="Original_CategoryID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>

    <br />
    <br />

    <asp:ListView ID="lsvProdDetails" runat="server" DataKeyNames="ProductID">

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

    <div class="container-fluid ">
        <br />
        <br />
        <asp:Label ID="lblItemAdded" runat="server" Text="..."></asp:Label>

        <br />
        <br />
        <div class="row">
            <div class="col-lg-2 col-md-3 col-xs-6">
                Quantity:&nbsp;&nbsp;
                <ajaxToolkit:ComboBox ID="cbxQuantity" runat="server" Width="25px">
                    <asp:ListItem Value="0">...</asp:ListItem>
                    <asp:ListItem Value="1">1</asp:ListItem>
                    <asp:ListItem Value="2">2</asp:ListItem>
                    <asp:ListItem Value="3">3</asp:ListItem>
                    <asp:ListItem Value="4">4</asp:ListItem>
                    <asp:ListItem Value="5">5</asp:ListItem>
                    <asp:ListItem Value="10">10</asp:ListItem>
                    <asp:ListItem Value="20">20</asp:ListItem>
                </ajaxToolkit:ComboBox>
                <asp:RangeValidator ID="vldQuantity" runat="server" Text="* Not enough units in stock." ControlToValidate="cbxQuantity" MinimumValue="1" MaximumValue='99' CssClass="validator-message" Type="Integer"></asp:RangeValidator>
            </div>

            <div class="col-lg-2 col-md-3 col-xs-6">
                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" />
            </div>
        </div>

    </div>
</asp:Content>

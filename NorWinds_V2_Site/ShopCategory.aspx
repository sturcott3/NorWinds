<%@ Page Title="Shop by Category" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ShopCategory.aspx.cs" Inherits="NorWinds_V2_Site.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <h3><%:Title %>: </h3>
    <br />
    <asp:ListView ID="lsvCategories" class="center-block" runat="server" DataKeyNames="CategoryID" DataSourceID="CatObjDataSrc">
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

    <asp:ListView ID="lsvProducts" runat="server" DataKeyNames="ProductID" DataSourceID="ProdObjDataSrc">

        <EmptyDataTemplate>
            <span>
                <h4>Please begin by choosing a Category</h4>
            </span>
        </EmptyDataTemplate>

        <ItemSeparatorTemplate>
            <div id="separatorDiv" style="border: 1px solid #0094ff;"></div>
        </ItemSeparatorTemplate>

        <ItemTemplate>
          
            <br />
            <a href="ProductDetails.aspx?ProdID=<%# Eval("ProductID") %>">
                <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
            </a>
            <br />
            Unit Price:
            <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# Eval("UnitPrice") %>' />
            <br />
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



    <asp:ObjectDataSource ID="ProdObjDataSrc" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCatIDNoDiscontinued" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.ProductsTableAdapter" UpdateMethod="Update">
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
            <asp:QueryStringParameter Name="CatID" QueryStringField="CatID" Type="Int32" />
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

</asp:Content>

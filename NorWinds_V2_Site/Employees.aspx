<%@ Page Title="Employee Area" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="NorWinds_V2_Site.Employees" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
       
    <style>
        .validator-message {
            color: red;
            font-style: italic;
        }
        .confirmation-message {
        color:darkblue;
        font-style:normal;
        }
    </style>

    <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-lg-12">
            <asp:Label ID="lblMessage" runat="server" Text="Choose a client and load their cart to begin"></asp:Label>
        </div>
    </div>

    <div class="row">

        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            Customer:<br />
            <ajaxToolkit:ComboBox ID="cbxCustomer" runat="server" DataSourceID="CustObjDataSrc" DataTextField="CompanyName" DataValueField="CustomerID" MaxLength="0" Style="display: inline;"></ajaxToolkit:ComboBox>
            <asp:ObjectDataSource ID="CustObjDataSrc" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUniqueCustIDS" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.CustomersTableAdapter"></asp:ObjectDataSource>
        </div>

        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            <br />
            <asp:Button ID="btnGetCustCart" runat="server" Text="Check Customer Cart" OnClick="btnGetCustCart_Click" />
        </div>
    </div>

    <br />
    <%--spacer--%>
    <div style="border: 1px solid white"></div>
    <br />

    <div class="row">
        <%-- interface for employees to switch between clients--%>
        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">
            Product:&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Qty:
            <br />
            <ajaxToolkit:ComboBox ID="cbxItemName" runat="server" DataSourceID="ProductsObjDataSrc" DataTextField="ProductName" DataValueField="ProductID" MaxLength="0" Style="display: inline;"></ajaxToolkit:ComboBox>
            <asp:ObjectDataSource ID="ProductsObjDataSrc" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NorWinds_V2_Site.NorwinDBTableAdapters.ProductsTableAdapter" UpdateMethod="Update">
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

            &emsp;

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
        </div>
        <div class="col-lg-5 col-md-5 col-sm-6 col-xs-6">

            <br />
            <asp:Button ID="btnAddToOrder" runat="server" Text="Add to Order" OnClick="btnAddToOrder_Click" />
        </div>
    </div>

    <br />
    <%--spacer--%>
    <div style="border: 1px solid white"></div>
    <br />

    <div class="row">
        <%-- display order --%>
        <div class="col-lg-12">
            <asp:ListView ID="lsvCart" runat="server" DataKeyNames="CartItemID">

                <EmptyDataTemplate>
                    <table style="" runat="server">
                        <tr>
                            <td>Client cart currently empty.
                            </td>
                        </tr>
                    </table>
                </EmptyDataTemplate>


                <ItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Label ID="ProductNameLabel" runat="server" Text='<%# Eval("ProductName") %>' />
                        </td>

                        <td style="text-align: right;">
                            <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                        </td>

                        <td style="text-align: center;">
                            <asp:Label ID="UnitPriceLabel" runat="server" Text='<%# String.Format("{0:C2}",Eval("UnitPrice")) %>' />
                        </td>

                        <td style="text-align: center;">
                            <asp:Label ID="SubtotalLabel" runat="server" Text='<%# String.Format("{0:C2}",Eval("SubTotal")) %>' />
                        </td>

                        <td>
                            <asp:Button ID="btnRemove" runat="server" Text="remove" OnClick="btnRemove_Click" CommandArgument='<%# Eval("ProductID") +","+ Eval("Quantity")+","+ Eval("CartItemId") %>' />
                        </td>
                    </tr>
                </ItemTemplate>

                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                    <tr runat="server" style="">
                                        <th runat="server" style="width: 200px;">Product</th>
                                        <th runat="server" style="width: 100px;">Quantity</th>
                                        <th runat="server" style="width: 150px;">&emsp;&emsp;Unit Price&emsp;</th>
                                        <th runat="server" style="width: 150px;">&emsp;Item Total&emsp;&emsp;</th>
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
        </div>
    </div>

    <br />
    <%--spacer--%>
    <div style="border: 1px solid white"></div>
    <br />

    <div class="row">
        <%-- Shipping date checker --%>
        <br />
        <div class="col-lg-5 col-md-5 col-xs-6">
            Date to ship:<br />
            <asp:TextBox ID="txtShipDate" runat="server"></asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="calShipDate" runat="server" TargetControlID="txtShipDate" />
            &emsp;<asp:Button ID="btnCheckShip" runat="server" Text="Check Shipping" OnClick="btnCheckShip_Click" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please choose a date" ControlToValidate="txtShipDate" CssClass="validator-message"></asp:RequiredFieldValidator>
        </div>

        <div class="col-lg-3 col-md-3 col-xs-6">
            Date of arrival:<br />
            <asp:Label ID="lblArrivalDate" runat="server" Text=""></asp:Label>
        </div>
    </div>

    <br />
    <%--spacer--%>
    <div style="border: 1px solid white"></div>
    <br />

    <div class="row">

        <div class="col-lg-12">
            <%-- confirm and submit --%>
            <br />
            <br />
            <asp:Button ID="btnConfirmOrder" runat="server" Text="Place Order" OnClick="btnConfirmOrder_Click" />
            <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnConfirmOrder" ConfirmText="Are you sure you want to place this order?" />
        </div>
    </div>

</asp:Content>

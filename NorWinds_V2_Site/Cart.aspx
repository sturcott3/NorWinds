<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="NorWinds_V2_Site.Cart" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" ConfirmText="Are you sure you want to place this order?">
    <style>
        .errorMessage {
        color:red;
        }
    </style>
    
    
    <h2><%: Title %></h2>
        <br />
    <br />
    <asp:Label ID="lblInitMessage" runat="server" Text="This page would get the Cart, if any, based on login. For testing it is hardcoded to a single lookup."></asp:Label>
    <br />
    <br />
    <div class="row">
        <br />
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        <br />
        <br />
        <asp:ListView ID="lsvCart" runat="server" DataKeyNames="CartItemID">

            <EmptyDataTemplate>
                <table style="" runat="server">
                    <tr>
                        <td>
                            Cart Empty. Please use the Shop tab to start your next order, or review order history in the Orders table
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
                                    <th runat="server" style="width: 50px;">Quantity</th>
                                    <th runat="server" style="width: 100px;">&emsp;&emsp;Unit Price&emsp;</th>
                                    <th runat="server" style="width: 100px;">&emsp;Item Total&emsp;&emsp;</th>
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

    <div class="row">
        <br />
        <div class="col-lg-5 col-md-5 col-xs-6">
            Date to ship:
                <asp:TextBox ID="txtShipDate" runat="server"></asp:TextBox>
            <ajaxToolkit:CalendarExtender ID="calShipDate" runat="server" TargetControlID="txtShipDate" />
            &emsp;<asp:Button ID="btnCheckShip" runat="server" Text="Check Shipping" OnClick="btnCheckShip_Click" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please choose a date" ControlToValidate="txtShipDate" CssClass="errorMessage"></asp:RequiredFieldValidator>
        </div>

        <div class="col-lg-3 col-md-3 col-xs-6">
            Date of arrival: 
                <asp:Label ID="lblArrivalDate" runat="server" Text=""></asp:Label>
        </div>
    </div>

    <div class="row">
        <br />
        <br />
        <asp:Button ID="btnConfirmOrder" runat="server" Text="Place Order" OnClick="btnConfirmOrder_Click" />
        <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnConfirmOrder" ConfirmText="Are you sure you want to place this order?" />
    </div>

</asp:Content>

<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="NorWinds_V2_Site.About" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

            <div class="row">
            <br />
            <div class="col-lg-2 col-md-3 col-xs-6">
            Date to ship:
                <asp:TextBox ID="txtShipDate" runat="server"></asp:TextBox>
                <ajaxToolkit:CalendarExtender  ID="calShipDate" runat="server" TargetControlID="txtShipDate" />
            </div>

            <div class="col-lg-2 col-md-3 col-xs-6">
                Date of arrival: 
                <asp:Label ID="lblArrivalDate" runat="server" Text=""></asp:Label>
            </div>
        </div>

</asp:Content>

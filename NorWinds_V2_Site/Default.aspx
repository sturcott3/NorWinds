<%@ Page Title="Landing" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NorWinds_V2_Site._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="home-banner" class="container-fluid">
        <div class="row">
        <h2>Welcome to the Northwinds Grocery online ordering system!</h2>
        </div>

        <div class="row">
            <asp:LoginView runat="server">
                <AnonymousTemplate>
                    <h4>Please login to begin shopping.</h4>
                    <%-- TODO show sale items here --%>
                </AnonymousTemplate>

                <LoggedInTemplate>
                    <%-- TODO display/list warnings/messages depending on which account type is logged in --%>
                </LoggedInTemplate>
            </asp:LoginView>
        </div>
    </div>

</asp:Content>

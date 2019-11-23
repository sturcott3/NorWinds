using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(NorWinds_V2_Site.Startup))]
namespace NorWinds_V2_Site
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}

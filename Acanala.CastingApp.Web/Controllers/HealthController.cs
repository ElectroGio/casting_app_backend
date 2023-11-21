using Microsoft.AspNetCore.Mvc;

namespace Acanala.CastingApp.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public async Task<IActionResult> Health()
        {
            await Task.CompletedTask;
            return Ok("OK");
        }
    }
}
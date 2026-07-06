using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using ProjectManagement.API.Data;
using ProjectManagement.API.DTOs;
using System.Linq;

namespace ProjectManagement.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public AuthController(ApplicationDbContext context)
        {
            _context = context;
        }

        [HttpPost("Login")]
        public IActionResult Login(LoginRequest request)
        {
            var usernameParam = new SqlParameter("@UserName", request.UserName);

            var passwordParam = new SqlParameter("@Password", request.Password);

            // Step 1: Validate User
            var validatedUser = _context.Users
                .FromSqlRaw(
                    "EXEC Login_ValidateUser @UserName, @Password",
                    usernameParam,
                    passwordParam)
                .AsEnumerable()
                .FirstOrDefault();

            if (validatedUser == null)
            {
                return Unauthorized("Invalid Username or Password");
            }

            // Step 2: Get User Details
            var userIdParam = new SqlParameter("@UserId", validatedUser.UserId);

            var user = _context.Users
                .FromSqlRaw(
                    "EXEC Login_GetUserDetails @UserId",
                    userIdParam)
                .AsEnumerable()
                .FirstOrDefault();

            if (user == null)
            {
                return NotFound("User details not found");
            }

            var response = new LoginResponse
            {
                UserId = user.UserId,
                UserName = user.UserName,
                Role = user.Role,
                Message = "Login Successful"
            };

            return Ok(response);
        }
    }
}
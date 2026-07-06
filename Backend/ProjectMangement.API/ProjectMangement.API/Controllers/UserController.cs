using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjectManagement.API.DTOs;
using System.Data;

namespace ProjectManagement.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public UserController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("GetAll")]
        public IActionResult GetAllUsers()
        {
            var users = new List<UserResponseDTO>();

            using SqlConnection con =
                new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

            using SqlCommand cmd =
                new SqlCommand("User_GetAll", con);

            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                users.Add(new UserResponseDTO
                {
                    UserId = Convert.ToInt32(reader["UserId"]),
                    UserName = reader["UserName"].ToString() ?? "",
                    FullName = reader["FullName"].ToString() ?? "",
                    Email = reader["Email"].ToString() ?? "",
                    Role = reader["Role"].ToString() ?? "",
                    IsActive = Convert.ToBoolean(reader["IsActive"])
                });
            }

            return Ok(users);
        }

        [HttpGet("GetById/{id}")]
        public IActionResult GetById(int id)
        {
            UserEditResponseDTO user = new();

            using SqlConnection con =
                new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

            using SqlCommand cmd =
                new SqlCommand("User_GetById", con);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@UserId", id);

            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                user.UserId = Convert.ToInt32(reader["UserId"]);
                user.UserName = reader["UserName"].ToString() ?? "";
                user.FullName = reader["FullName"].ToString() ?? "";
                user.Email = reader["Email"].ToString() ?? "";
                user.Password = reader["Password"].ToString() ?? "";
                user.Role = reader["Role"].ToString() ?? "";
                user.IsActive = Convert.ToBoolean(reader["IsActive"]);
            }

            return Ok(user);
        }

        [HttpPost("Save")]
        public IActionResult SaveUser(UserRequestDTO request)
        {
            try
            {
                using SqlConnection con =
                    new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                using SqlCommand cmd =
                    new SqlCommand("User_Save", con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserId", request.UserId);
                cmd.Parameters.AddWithValue("@UserName", request.UserName);
                cmd.Parameters.AddWithValue("@FullName", request.FullName);
                cmd.Parameters.AddWithValue("@Email", request.Email);
                cmd.Parameters.AddWithValue("@Password", request.Password);
                cmd.Parameters.AddWithValue("@Role", request.Role);
                cmd.Parameters.AddWithValue("@CreatedBy", request.CreatedBy);

                con.Open();
                cmd.ExecuteNonQuery();

                return Ok("User Saved Successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("Delete/{id}")]
        public IActionResult DeleteUser(int id)
        {
            try
            {
                using SqlConnection con =
                    new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                using SqlCommand cmd =
                    new SqlCommand("User_Delete", con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserId", id);

                con.Open();
                cmd.ExecuteNonQuery();

                return Ok("User Deleted Successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
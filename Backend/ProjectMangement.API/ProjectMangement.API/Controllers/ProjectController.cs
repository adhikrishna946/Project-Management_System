using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjectManagement.API.DTOs;
using System.Data;

namespace ProjectManagement.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProjectController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ProjectController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("GetAll")]
        public IActionResult GetAllProjects()
        {
            var projects = new List<ProjectResponseDTO>();

            using SqlConnection con =
                new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

            using SqlCommand cmd =
                new SqlCommand("Project_GetAll", con);

            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                projects.Add(new ProjectResponseDTO
                {
                    ProjectId = Convert.ToInt32(reader["ProjectId"]),
                    ProjectCode = reader["ProjectCode"].ToString() ?? "",
                    ProjectName = reader["ProjectName"].ToString() ?? "",
                    Description = reader["Description"].ToString() ?? "",
                    StartDate = reader["StartDate"] == DBNull.Value ? null : Convert.ToDateTime(reader["StartDate"]),
                    EndDate = reader["EndDate"] == DBNull.Value ? null : Convert.ToDateTime(reader["EndDate"]),
                    Status = reader["Status"].ToString() ?? "",
                    IsActive = Convert.ToBoolean(reader["IsActive"])
                });
            }

            return Ok(projects);
        }
        [HttpGet("GetById/{id}")]
        public IActionResult GetById(int id)
        {
            ProjectEditResponseDTO project = new();

            using SqlConnection con =
                new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

            using SqlCommand cmd =
                new SqlCommand("Project_GetById", con);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ProjectId", id);

            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                project.ProjectId = Convert.ToInt32(reader["ProjectId"]);
                project.ProjectCode = reader["ProjectCode"].ToString() ?? "";
                project.ProjectName = reader["ProjectName"].ToString() ?? "";
                project.Description = reader["Description"].ToString() ?? "";
                project.StartDate = reader["StartDate"] == DBNull.Value ? null : Convert.ToDateTime(reader["StartDate"]);
                project.EndDate = reader["EndDate"] == DBNull.Value ? null : Convert.ToDateTime(reader["EndDate"]);
                project.Status = reader["Status"].ToString() ?? "";
                project.IsActive = Convert.ToBoolean(reader["IsActive"]);
            }

            return Ok(project);
        }
        [HttpPost("Save")]
        public IActionResult SaveProject(ProjectRequestDTO request)
        {
            try
            {
                using SqlConnection con =
                    new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                using SqlCommand cmd =
                    new SqlCommand("Project_Save", con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProjectId", request.ProjectId);
                cmd.Parameters.AddWithValue("@ProjectCode", request.ProjectCode);
                cmd.Parameters.AddWithValue("@ProjectName", request.ProjectName);
                cmd.Parameters.AddWithValue("@Description", request.Description);
                cmd.Parameters.AddWithValue("@StartDate", (object?)request.StartDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@EndDate", (object?)request.EndDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Status", request.Status);
                cmd.Parameters.AddWithValue("@CreatedBy", request.CreatedBy);

                con.Open();

                cmd.ExecuteNonQuery();

                return Ok("Project Saved Successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpDelete("Delete/{id}")]
        public IActionResult DeleteProject(int id)
        {
            try
            {
                using SqlConnection con =
                    new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                using SqlCommand cmd =
                    new SqlCommand("Project_Delete", con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProjectId", id);

                con.Open();

                cmd.ExecuteNonQuery();

                return Ok("Project Deleted Successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
    
}
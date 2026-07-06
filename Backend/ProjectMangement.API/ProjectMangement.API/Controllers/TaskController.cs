using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using ProjectManagement.API.DTOs;
using System.Data;

namespace ProjectManagement.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TaskController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public TaskController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("GetAll")]
        public IActionResult GetAllTasks()
        {
            var tasks = new List<TaskResponseDTO>();

            using SqlConnection con =
                new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

            using SqlCommand cmd =
                new SqlCommand("Task_GetAll", con);

            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                tasks.Add(new TaskResponseDTO
                {
                    TaskId = Convert.ToInt32(reader["TaskId"]),
                    ProjectId = Convert.ToInt32(reader["ProjectId"]),
                    AssignedUserId = Convert.ToInt32(reader["AssignedUserId"]),
                    TaskName = reader["TaskName"].ToString() ?? "",
                    Description = reader["Description"].ToString() ?? "",
                    Priority = reader["Priority"].ToString() ?? "",
                    Status = reader["Status"].ToString() ?? "",
                    DueDate = reader["DueDate"] == DBNull.Value ? null : Convert.ToDateTime(reader["DueDate"]),
                    IsActive = Convert.ToBoolean(reader["IsActive"])
                });
            }

            return Ok(tasks);
        }

        [HttpGet("GetById/{id}")]
        public IActionResult GetById(int id)
        {
            TaskEditResponseDTO task = new();

            using SqlConnection con =
                new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

            using SqlCommand cmd =
                new SqlCommand("Task_GetById", con);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@TaskId", id);

            con.Open();

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                task.TaskId = Convert.ToInt32(reader["TaskId"]);
                task.ProjectId = Convert.ToInt32(reader["ProjectId"]);
                task.AssignedUserId = Convert.ToInt32(reader["AssignedUserId"]);
                task.TaskName = reader["TaskName"].ToString() ?? "";
                task.Description = reader["Description"].ToString() ?? "";
                task.Priority = reader["Priority"].ToString() ?? "";
                task.Status = reader["Status"].ToString() ?? "";
                task.DueDate = reader["DueDate"] == DBNull.Value ? null : Convert.ToDateTime(reader["DueDate"]);
                task.IsActive = Convert.ToBoolean(reader["IsActive"]);
            }

            return Ok(task);
        }

        [HttpPost("Save")]
        public IActionResult SaveTask(TaskRequestDTO request)
        {
            try
            {
                using SqlConnection con =
                    new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                using SqlCommand cmd =
                    new SqlCommand("Task_Save", con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TaskId", request.TaskId);
                cmd.Parameters.AddWithValue("@ProjectId", request.ProjectId);
                cmd.Parameters.AddWithValue("@AssignedUserId", request.AssignedUserId);
                cmd.Parameters.AddWithValue("@TaskName", request.TaskName);
                cmd.Parameters.AddWithValue("@Description", request.Description);
                cmd.Parameters.AddWithValue("@Priority", request.Priority);
                cmd.Parameters.AddWithValue("@Status", request.Status);
                cmd.Parameters.AddWithValue("@DueDate", (object?)request.DueDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@CreatedBy", request.CreatedBy);

                con.Open();

                cmd.ExecuteNonQuery();

                if (request.TaskId == 0)
                    return Ok("Task Saved Successfully");
                else
                    return Ok("Task Updated Successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("Delete/{id}")]
        public IActionResult DeleteTask(int id)
        {
            try
            {
                using SqlConnection con =
                    new SqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                using SqlCommand cmd =
                    new SqlCommand("Task_Delete", con);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TaskId", id);

                con.Open();

                cmd.ExecuteNonQuery();

                return Ok("Task Deleted Successfully");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
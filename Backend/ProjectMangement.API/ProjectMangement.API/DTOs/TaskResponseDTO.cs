namespace ProjectManagement.API.DTOs
{
    public class TaskResponseDTO
    {
        public int TaskId { get; set; }

        public int ProjectId { get; set; }

        public int AssignedUserId { get; set; }

        public string TaskName { get; set; } = "";

        public string Description { get; set; } = "";

        public string Priority { get; set; } = "";

        public string Status { get; set; } = "";

        public DateTime? DueDate { get; set; }

        public bool IsActive { get; set; }
    }
}
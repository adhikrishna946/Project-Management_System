namespace ProjectManagement.API.DTOs
{
    public class UserRequestDTO
    {
        public int UserId { get; set; }

        public string UserName { get; set; } = string.Empty;

        public string FullName { get; set; } = string.Empty;

        public string Email { get; set; } = string.Empty;

        public string Password { get; set; } = string.Empty;

        public string Role { get; set; } = string.Empty;

        public string CreatedBy { get; set; } = string.Empty;
    }
}
namespace ProjectManagement.API.DTOs
{
    public class LoginResponse
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public string Role { get; set; }
        public string Message { get; set; }
    }
}
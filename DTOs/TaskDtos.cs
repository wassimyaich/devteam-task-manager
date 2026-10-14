using System;
using DevTeamTaskManager.Api.Enums;

namespace DevTeamTaskManager.Api.DTOs
{
    public class CreateTaskDto
    {
        public string Client { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int AssigneeId { get; set; }
        public decimal EstimatedHours { get; set; }
        public DateTime DueDate { get; set; }
        public Priority Priority { get; set; }
        public int? SprintId { get; set; }
    }

    public class UpdateTaskDto : CreateTaskDto
    {
        public Status Status { get; set; }
    }

    public class InlineUpdateTaskDto
    {
        public decimal? EstimatedHours { get; set; }
        public DateTime? DueDate { get; set; }
    }

    public class UpdateTaskStatusDto
    {
        public Status Status { get; set; }
    }

    public class TaskResponseDto
    {
        public int Id { get; set; }
        public string Client { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int AssigneeId { get; set; }
        public string AssigneeName { get; set; } = string.Empty;
        public decimal EstimatedHours { get; set; }
        public DateTime DueDate { get; set; }
        public Priority Priority { get; set; }
        public Status Status { get; set; }
        public int? SprintId { get; set; }
        public string? SprintName { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
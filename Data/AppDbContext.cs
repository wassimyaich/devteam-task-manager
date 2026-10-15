using Microsoft.EntityFrameworkCore;
using DevTeamTaskManager.Api.Entities;
using DevTeamTaskManager.Api.Enums;
using System;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace DevTeamTaskManager.Api.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Developer> Developers => Set<Developer>();
        public DbSet<Sprint> Sprints => Set<Sprint>();
        public DbSet<TaskItem> Tasks => Set<TaskItem>();
        public DbSet<TimeEntry> TimeEntries => Set<TimeEntry>();

        protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
        {
            base.ConfigureConventions(configurationBuilder);

            // Convertit automatiquement tous les DateTime en UTC pour PostgreSQL (timestamp with time zone)
            configurationBuilder
                .Properties<DateTime>()
                .HaveConversion<UtcValueConverter>();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure Decimal Precisions
            modelBuilder.Entity<TaskItem>()
                .Property(t => t.EstimatedHours)
                .HasColumnType("decimal(18,2)");

            modelBuilder.Entity<TimeEntry>()
                .Property(te => te.DurationHours)
                .HasColumnType("decimal(18,2)");

            // Configure Delete Behaviors (Prevent accidental cascading drops of time entries when deleting tasks)
            modelBuilder.Entity<TaskItem>()
                .HasMany(t => t.TimeEntries)
                .WithOne(te => te.Task)
                .HasForeignKey(te => te.TaskId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Developer>()
                .HasMany(d => d.TimeEntries)
                .WithOne(te => te.Developer)
                .HasForeignKey(te => te.DeveloperId)
                .OnDelete(DeleteBehavior.Restrict);

            // Seed Initial Development Data (Safe against duplicates)
            modelBuilder.Entity<Developer>().HasData(
                new Developer { Id = 1, Name = "Wassim Yaich", Email = "wassim@devteam.local" },
                new Developer { Id = 2, Name = "Sarah Ben Ali", Email = "sarah@devteam.local" },
                new Developer { Id = 3, Name = "Mehdi Trabelsi", Email = "mehdi@devteam.local" }
            );

            modelBuilder.Entity<Sprint>().HasData(
                new Sprint
                {
                    Id = 1,
                    Name = "Sprint 1 - MVP Foundation",
                    StartDate = new DateTime(2026, 10, 1, 0, 0, 0, DateTimeKind.Utc),
                    EndDate = new DateTime(2026, 10, 15, 0, 0, 0, DateTimeKind.Utc),
                    Status = SprintStatus.Active
                }
            );
        }
    }

    public class UtcValueConverter : ValueConverter<DateTime, DateTime>
    {
        public UtcValueConverter() : base(
            v => DateTime.SpecifyKind(v, DateTimeKind.Utc),
            v => DateTime.SpecifyKind(v, DateTimeKind.Utc))
        { }
    }
}
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FindYourClinic.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class AddHealthRecordAttachments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "CloudinaryPublicId",
                table: "HealthRecords",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "FileUrl",
                table: "HealthRecords",
                type: "nvarchar(1000)",
                maxLength: 1000,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CloudinaryPublicId",
                table: "HealthRecords");

            migrationBuilder.DropColumn(
                name: "FileUrl",
                table: "HealthRecords");
        }
    }
}

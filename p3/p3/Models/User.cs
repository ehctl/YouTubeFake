using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace p3.Models
{
    public class User
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public int Account_status { get; set; }
        public string Username { get ; set; }
        public string Password { get ; set ; }        
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public string Avatar { get ; set ; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime Created_date { get ; set ; }
        public string Email { get ; set ; }
        public DateTime Birth_date { get ; set ; }
        public string First_name { get ; set ; }
        public string Last_name { get ; set; }
        public string Channel_name { get; set ; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public string Background_image { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public string Description { get; set; }
        public int Subscriber { get; set; }
        public string Active_code { get; set; }
        public string Sad_code { get; set; }
    }
}
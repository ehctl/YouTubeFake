using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class Video
    {
        [Key]
        public string Id { get; set; }
        public string Name { get; set; }
        public string Title { get; set; }
        public DateTime Created_date { get; set; }
        public int Owner_id { get; set; }
        public int View { get; set; }
        public string Description { get; set; }
        public string Video_format { get; set; }
        public int Duration { get; set; }
        public int Comment { get; set; }
    }
}
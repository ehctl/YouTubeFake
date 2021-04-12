using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class VideoTag
    {
        [Key]
        public int Id { get; set; }
        public string Video_id { get; set; }
        public int Tag_id { get; set; }
    }
}
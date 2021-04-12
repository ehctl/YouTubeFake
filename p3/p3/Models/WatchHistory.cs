using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class WatchHistory
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Video_id { get; set; }
        public int User_id { get; set; }
        public DateTime Time { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public int Status { get; set; }
        public int Watch_time { get; set; }
    }
}
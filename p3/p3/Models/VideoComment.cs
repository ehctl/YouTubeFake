using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class VideoComment
    {       
        [Key]

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Video_id { get; set; }
        public int Owner_id { get; set; }
        public string Comment { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public int Status { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime Created_at { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime Updated_at { get; set; }
    }
}
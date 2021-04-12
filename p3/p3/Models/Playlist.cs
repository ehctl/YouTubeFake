using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class Playlist
    {
        [Key]

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string Name { get; set; }
        public int Owner_id { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime Created_at { get; set; }
        public DateTime Last_modified { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public int Quantity { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public string Description { get; set; }
    }
}
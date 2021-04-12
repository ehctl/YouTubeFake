using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class Subscriber
    {
        public static int SUBSCRIBE_ACTION = 0;
        public static int UNSUBSCRIBE_ACTION = 1;

        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int Id { get; set; }
        public int Channel_id { get; set; }
        public int User_id { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime Time { get; set;}
        public int Action { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace p3.Models
{
    public class SearchQuery
    {
        public enum SearchQueryStatus
        {
            normal=0,
            stricted=1,
            deleted=2
        }

        [Key]  
        public int Id { get; set; }
        public int User_id { get ; set ; }
        public string Search_query { get ; set ; }
        public DateTime Searched_at { get; set; }
        public int Query_status { get; set; }
    }
}
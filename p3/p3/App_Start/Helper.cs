using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace p3.Controllers
{
    public class Helper
    {
        private static Random random = new Random();

        public static string EncryptSha256(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                // ComputeHash - returns byte array  
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));

                // Convert byte array to a string   
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        public static string CalculateDuration(int Duration)
        {
            int hour = Duration / 3600;
            int minute = (Duration % 3600) / 60;
            int second = Duration % 60;

            string dur = hour == 0 ? "" : hour + ":";

            string m;
            if (minute == 0) m = "0";
            else if (minute < 10 && hour >= 1) m = "0" + minute;
            else m = minute + "";

            dur += m + ":";

            dur += second < 10 ? "0" + second : second + "";
            return dur;
        }

        public static string CalculateView(int view)
        {
            String outputView = "";
            if (view < 1000)
            {
                outputView += view + " views";
            }
            else if (view > 1000 && view < 1000000)
            {
                outputView += view / 1000 + "." + (view % 1000) / 100 + " k views";
            }
            else if (view > 1000000)
            {
                outputView += view / 1000000 + "." + (view % 1000000) / 100000 + " mil views";
            }

            return outputView;
        }

        public static string CalculateDay(DateTime Created_date)
        {
            string outputDay = "";
            TimeSpan gap = DateTime.Now.Subtract(Created_date);
            if (gap.TotalDays > 365)
            {
                outputDay = Math.Round(gap.TotalDays / 365) + " year ago";
            }
            else if (gap.TotalDays > 31)
            {
                outputDay = Math.Round(gap.TotalDays / 31) + " month ago";
            }
            else if (gap.TotalDays >= 1)
            {
                outputDay = Math.Round(gap.TotalDays) + " day ago";
            }
            else if (gap.TotalHours >= 1)
            {
                outputDay = Math.Round(gap.TotalHours) + " hour ago";
            }
            else if (gap.TotalMinutes >= 1)
            {
                outputDay = Math.Round(gap.TotalMinutes) + " minute ago";
            }
            else
            {
                outputDay = Math.Round(gap.TotalSeconds) + " second ago";
            }

            return outputDay;
        }

        public static void ShuffleArray<T>(ref T[] inputArray)
        {
            Random random = new Random();
            for (int i = inputArray.Length - 1; i > 0; i--)
            {
                int randomIndex = random.Next(0, i + 1);

                T temp = inputArray[i];
                inputArray[i] = inputArray[randomIndex];
                inputArray[randomIndex] = temp;
            }
        }
    }
}
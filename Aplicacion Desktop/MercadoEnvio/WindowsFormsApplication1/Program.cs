using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Windows.Forms;
using System.Configuration;

namespace WindowsFormsApplication1
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        /// 

        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Login.Login());
            //Application.Run(new Menu());

            return;
        }

        public static SqlConnection conexionDB()
        {
            string configuracion = ConfigurationManager.AppSettings["configuracionSQL"].ToString();
            SqlConnection conexion = new SqlConnection(configuracion);
            conexion.Open();
            return conexion;
        }

    }
}

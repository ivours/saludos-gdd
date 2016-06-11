using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Calificar
{
    public partial class OperacionesSinCalificar : Form
    {
        String username;

        public OperacionesSinCalificar(String username)
        {
            InitializeComponent();
            this.username = username;
            ConfiguradorDataGrid.configurar(dataGridView1);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.califificacionesPendientes(), dataGridView1);
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private int cantidadCalificacionesPendientes()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadCalificacionesPendientes(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int)reader.GetValue(0);
        }

        private SqlDataReader califificacionesPendientes()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.calificacionesPendientes(@usuario)";
            consulta.Parameters.Add(new SqlParameter("@usuario", this.username));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            String vendedor = dataGridView1.SelectedRows[0].Cells[0].Value.ToString();
            int codigoPublicacion =  Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[1].Value);

            Calificar.CalificarOperacion calificarOperacion = new CalificarOperacion(username, vendedor, codigoPublicacion);
            calificarOperacion.Show();
            this.Close();
        }
    }
}

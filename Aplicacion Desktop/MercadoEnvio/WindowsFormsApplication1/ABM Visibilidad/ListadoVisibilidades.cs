using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ABM_Visibilidad
{
    public partial class ListadoVisibilidades : Form
    {
        Form formAnterior;

        public ListadoVisibilidades(Form formAnterior)
        {
            InitializeComponent();
            ConfiguradorDataGrid.configurar(dataGridView1);
            this.formAnterior = formAnterior;
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getVisibilidades(), dataGridView1);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        //TODO: Agregar filtros
        private SqlDataReader getVisibilidades()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.VISIBILIDADES";
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            String nombreVisibilidad;
            decimal comisionPorPublicar;
            decimal comisionPorVender;
            decimal comisionPorEnvio;
            formAnterior.Name = "ModificarVisibilidad";

            //Ver orden columnas
            switch (formAnterior.Name)
            {
                case "ModificarVisibilidad":

                    nombreVisibilidad = dataGridView1.SelectedRows[0].Cells[3].Value.ToString();
                    comisionPorPublicar = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[1].Value);
                    comisionPorVender = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[2].Value);
                    comisionPorEnvio = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[3].Value.ToString());
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setNombreVisibilidad(nombreVisibilidad);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setComisionPorPublicar(comisionPorPublicar);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setComisionPorVender(comisionPorVender);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setComisionPorEnvio(comisionPorEnvio);
                    formAnterior.Show();
                    break;
            }

            this.Close();
        }

        
        
    }
}

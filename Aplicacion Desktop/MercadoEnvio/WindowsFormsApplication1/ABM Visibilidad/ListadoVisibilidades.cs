using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Visibilidad
{
    public partial class ListadoVisibilidades : Form
    {
        Form formAnterior;

        public ListadoVisibilidades(Form formAnterior)
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
            ConfiguradorDataGrid.configurar(dataGridView1);
            this.formAnterior = formAnterior;
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }

        private Object filtrarDescripcion()
        {
            if (textBox1.Text.Equals(""))
                return DBNull.Value;
            else
                return textBox1.Text;
        }

        private SqlDataReader getVisibilidades()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.getVisibilidades(@descripcion)";
            consulta.Parameters.Add(new SqlParameter("@descripcion", this.filtrarDescripcion()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            int codigoVisibilidad;
            String nombreVisibilidad;
            decimal comisionPorPublicar;
            decimal comisionPorVender;
            decimal comisionPorEnvio;

            switch (formAnterior.Name)
            {
                case "BajaVisibilidad":
                    
                    nombreVisibilidad = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();

                    try
                    {
                        (formAnterior as ABM_Visibilidad.BajaVisibilidad).bajaVisibilidad(nombreVisibilidad);
                        MessageBox.Show("Se ha dado de baja la visibilidad '" + nombreVisibilidad + "'");
                        ConfiguradorDataGrid.llenarDataGridConConsulta(this.getVisibilidades(), dataGridView1);
                    }
                    catch(Exception excepcion)
                    {
                        MessageBox.Show(excepcion.Message, "Error", MessageBoxButtons.OK);
                    }

                    break;

                case "ModificarVisibilidad":

                    codigoVisibilidad = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value);
                    nombreVisibilidad = dataGridView1.SelectedRows[0].Cells[1].Value.ToString();
                    comisionPorPublicar = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[2].Value);
                    comisionPorVender = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[3].Value) * 100;
                    comisionPorEnvio = Convert.ToDecimal(dataGridView1.SelectedRows[0].Cells[4].Value) * 100;
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setCodigoVisibilidad(codigoVisibilidad);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setNombreVisibilidad(nombreVisibilidad);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setComisionPorPublicar(comisionPorPublicar);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setComisionPorVender(comisionPorVender);
                    (formAnterior as ABM_Visibilidad.ModificarVisibilidad).setComisionPorEnvio(comisionPorEnvio);
                    formAnterior.Show();
                    this.Close();
                    break;
            }
            
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            ConfiguradorDataGrid.llenarDataGridConConsulta(this.getVisibilidades(), dataGridView1);
        }

        private void limpiarCampos()
        {
            textBox1.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.limpiarCampos();
        }
        
    }
}

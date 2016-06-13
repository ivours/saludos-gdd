using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.ComprarOfertar
{
    public partial class ListadoPublicaciones : Form
    {
        int paginaActual;
        int ultimaPagina;
        String username;

        public ListadoPublicaciones(String username)
        {
            InitializeComponent();
            this.username = username;
            ConfiguradorDataGrid.configurar(dataGridView1);
            paginaActual = 1;
            ultimaPagina = 1;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private Object filtrarDescripcion()
        {
            if (textBox3.Text.Equals(""))
                return DBNull.Value;
            else
                return textBox3.Text;
        }

        private SqlDataReader mostrarPublicacionesSinFiltroRubros()
        {
            List<String> rubrosFiltrados = new List<String>();

            for (int i = 0; i < listBox1.Items.Count; i++)
            {
                rubrosFiltrados.Add(listBox1.Items[i].ToString());
            }

            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT * from GD1C2016.SALUDOS.mostrarPublicaciones(@descripcion, @rubro) ORDER BY Código OFFSET ((@NUM_PAG - 1) * 10) ROWS FETCH NEXT 10 ROWS ONLY";
            consulta.Parameters.Add(new SqlParameter("@descripcion", this.filtrarDescripcion()));
            consulta.Parameters.Add(new SqlParameter("@rubro", DBNull.Value));
            consulta.Parameters.Add(new SqlParameter("@NUM_PAG", paginaActual));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private int cantidadPaginasPublicacionesConFiltroRubros()
        {
            List<String> rubrosFiltrados = new List<String>();

            for (int i = 0; i < listBox1.Items.Count; i++)
            {
                rubrosFiltrados.Add(listBox1.Items[i].ToString());
            }

            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT COUNT(*) FROM SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr, SALUDOS.TIPOS tipo WHERE	1 = (	SELECT USUA_HABILITADO FROM SALUDOS.USUARIOS usua WHERE usua.USUA_USERNAME = publ.USUA_USERNAME) AND (PUBL_DESCRIPCION LIKE '%' + @descripcion + '%' OR @descripcion IS NULL) AND publ.RUBR_COD = rubr.RUBR_COD AND publ.RUBR_COD IN (	SELECT RUBR_COD FROM SALUDOS.RUBROS WHERE RUBR_NOMBRE IN (" + Extras.ConcatenadorDeStrings.concatenarStringsSeparadosConComa(rubrosFiltrados) + ")) AND publ.TIPO_COD =	tipo.TIPO_COD AND ESTA_COD = (	SELECT ESTA_COD FROM SALUDOS.ESTADOS WHERE ESTA_NOMBRE = 'Activa')";
            consulta.Parameters.Add(new SqlParameter("@descripcion", this.filtrarDescripcion()));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            int cantidadDePaginas = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(reader.GetValue(0)) / 10));

            return cantidadDePaginas;
        }

        private int cantidadPaginasPublicacionesSinFiltroRubros()
        {
            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT GD1C2016.SALUDOS.cantidadDePaginasPublicaciones(@descripcion, @rubro)";
            consulta.Parameters.Add(new SqlParameter("@descripcion", this.filtrarDescripcion()));
            consulta.Parameters.Add(new SqlParameter("@rubro", DBNull.Value));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();
            reader.Read();

            return (int) reader.GetValue(0);
        }

        private SqlDataReader mostrarPublicacionesConFiltroRubros()
        {
            List<String> rubrosFiltrados = new List<String>();

            for (int i = 0; i < listBox1.Items.Count; i++)
            {
                rubrosFiltrados.Add(listBox1.Items[i].ToString());
            }

            SqlDataReader reader;
            SqlCommand consulta = new SqlCommand();
            consulta.CommandType = CommandType.Text;
            consulta.CommandText = "SELECT	PUBL_COD, PUBL_DESCRIPCION, PUBL_PRECIO, RUBR_NOMBRE, TIPO_NOMBRE, CASE WHEN PUBL_PERMITE_ENVIO = 1 THEN 'Sí' ELSE 'No' END AS Envío FROM SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr, SALUDOS.TIPOS tipo WHERE	1 = (	SELECT USUA_HABILITADO FROM SALUDOS.USUARIOS usua WHERE usua.USUA_USERNAME = publ.USUA_USERNAME) AND (PUBL_DESCRIPCION LIKE '%' + @descripcion + '%' OR @descripcion IS NULL) AND publ.RUBR_COD = rubr.RUBR_COD AND publ.RUBR_COD IN (	SELECT RUBR_COD FROM SALUDOS.RUBROS WHERE RUBR_NOMBRE IN (" + Extras.ConcatenadorDeStrings.concatenarStringsSeparadosConComa(rubrosFiltrados) + ")) AND publ.TIPO_COD =	tipo.TIPO_COD AND ESTA_COD = (	SELECT ESTA_COD FROM SALUDOS.ESTADOS WHERE ESTA_NOMBRE = 'Activa') ORDER BY VISI_COD OFFSET ((@NUM_PAG - 1) * 10) ROWS FETCH NEXT 10 ROWS ONLY";
            consulta.Parameters.Add(new SqlParameter("@descripcion", this.filtrarDescripcion()));
            consulta.Parameters.Add(new SqlParameter("@NUM_PAG", paginaActual));
            consulta.Connection = Program.conexionDB();
            reader = consulta.ExecuteReader();

            return reader;
        }

        private void button7_Click(object sender, EventArgs e)
        {
            ABM_Rubro.ListadoRubros listadoRubros = new ABM_Rubro.ListadoRubros(this);
            listadoRubros.Show();
        }

        public void addRubro(String rubro)
        {
            if(!listBox1.Items.Contains(rubro))
                listBox1.Items.Add(rubro);
        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

            this.paginaActual = 1;
            textBox4.Text = this.paginaActual.ToString();

            if (listBox1.Items.Count.Equals(0))
            {
                this.ultimaPagina = this.cantidadPaginasPublicacionesSinFiltroRubros();
                textBox5.Text = this.ultimaPagina.ToString();
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesSinFiltroRubros(), dataGridView1);
            }
            else
            {
                this.ultimaPagina = this.cantidadPaginasPublicacionesConFiltroRubros();
                textBox5.Text = this.ultimaPagina.ToString();
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesConFiltroRubros(), dataGridView1);
            }
            
        }

        private void avanzarPagina()
        {
            if (paginaActual < ultimaPagina)
            {
                paginaActual = paginaActual + 1;
                textBox4.Text = this.paginaActual.ToString();

                if(listBox1.Items.Count.Equals(0))
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesSinFiltroRubros(), dataGridView1);
                else
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesConFiltroRubros(), dataGridView1);
            }
        }

        private void retrocederPagina()
        {
            if (paginaActual > 1)
            {
                paginaActual = paginaActual - 1;
                textBox4.Text = this.paginaActual.ToString();

                if (listBox1.Items.Count.Equals(0))
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesSinFiltroRubros(), dataGridView1);
                else
                    ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesConFiltroRubros(), dataGridView1);
            }
        }

        private void irAPrimeraPagina()
        {
            paginaActual = 1;
            textBox4.Text = this.paginaActual.ToString();

            if (listBox1.Items.Count.Equals(0))
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesSinFiltroRubros(), dataGridView1);
            else
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesConFiltroRubros(), dataGridView1);
        }

        private void irAUltimaPagina()
        {
            paginaActual = ultimaPagina;
            textBox4.Text = this.paginaActual.ToString();

            if (listBox1.Items.Count.Equals(0))
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesSinFiltroRubros(), dataGridView1);
            else
                ConfiguradorDataGrid.llenarDataGridConConsulta(this.mostrarPublicacionesConFiltroRubros(), dataGridView1);

        }

        private void button5_Click(object sender, EventArgs e)
        {
            this.irAPrimeraPagina();
        }

        private void button3_Click_1(object sender, EventArgs e)
        {
            this.retrocederPagina();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.avanzarPagina();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.irAUltimaPagina();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            textBox3.Clear();
            textBox4.Clear();
            textBox5.Clear();
            listBox1.Items.Clear();
            dataGridView1.DataSource = null;
            dataGridView1.Refresh();
        }

        private void button8_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button9_Click(object sender, EventArgs e)
        {
            if (!dataGridView1.SelectedRows.Count.Equals(0))
            {
                int codigoPublicacion = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells[0].Value);
                String tipoPublicacion = dataGridView1.SelectedRows[0].Cells[4].Value.ToString();

                if (tipoPublicacion.Equals("Compra Inmediata"))
                {
                    ComprarOfertar.Comprar comprar = new Comprar(codigoPublicacion, this.username);
                    comprar.Show();
                }
                else
                {
                    ComprarOfertar.Ofertar ofertar = new Ofertar(codigoPublicacion, this.username);
                    ofertar.Show();
                }
            }

            this.Close();
        }

        private void ListadoPublicaciones_Load(object sender, EventArgs e)
        {

        }

        
    }
}

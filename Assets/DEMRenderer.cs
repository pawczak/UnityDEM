using Mapbox.Examples.Voxels;
using UnityEngine;

public class DEMRenderer : MonoBehaviour {
    public VoxelTile voxelTile;
    
    public void OnPostRender() {
        if (voxelTile != null) {
            voxelTile.renderTerrain();
        }
    }
}

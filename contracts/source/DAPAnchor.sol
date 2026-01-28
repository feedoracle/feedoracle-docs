// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title DAPAnchor
 * @notice FeedOracle Disclosure Attestation Protocol - Merkle Root Anchoring
 * @dev Stores Merkle roots of attestation batches for immutable verification
 */
contract DAPAnchor {
    address public owner;
    
    struct Anchor {
        bytes32 merkleRoot;
        uint256 timestamp;
        uint256 leafCount;
        string treeId;
        bool exists;
    }
    
    // Anchor ID => Anchor data
    mapping(bytes32 => Anchor) public anchors;
    
    // Array of all anchor IDs for enumeration
    bytes32[] public anchorIds;
    
    // Latest anchor
    bytes32 public latestAnchorId;
    bytes32 public latestMerkleRoot;
    uint256 public latestTimestamp;
    uint256 public totalAnchors;
    
    event MerkleRootAnchored(
        bytes32 indexed anchorId,
        bytes32 merkleRoot,
        uint256 timestamp,
        uint256 leafCount,
        string treeId
    );
    
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "DAPAnchor: caller is not owner");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }
    
    /**
     * @notice Anchor a new Merkle root
     * @param merkleRoot The root hash of the attestation Merkle tree
     * @param leafCount Number of attestations in this batch
     * @param treeId Off-chain identifier for this tree
     */
    function anchorMerkleRoot(
        bytes32 merkleRoot,
        uint256 leafCount,
        string calldata treeId
    ) external onlyOwner returns (bytes32 anchorId) {
        require(merkleRoot != bytes32(0), "DAPAnchor: invalid merkle root");
        require(leafCount > 0, "DAPAnchor: leaf count must be positive");
        
        // Generate anchor ID from merkle root and timestamp
        anchorId = keccak256(abi.encodePacked(merkleRoot, block.timestamp, totalAnchors));
        
        require(!anchors[anchorId].exists, "DAPAnchor: anchor already exists");
        
        anchors[anchorId] = Anchor({
            merkleRoot: merkleRoot,
            timestamp: block.timestamp,
            leafCount: leafCount,
            treeId: treeId,
            exists: true
        });
        
        anchorIds.push(anchorId);
        latestAnchorId = anchorId;
        latestMerkleRoot = merkleRoot;
        latestTimestamp = block.timestamp;
        totalAnchors++;
        
        emit MerkleRootAnchored(anchorId, merkleRoot, block.timestamp, leafCount, treeId);
        
        return anchorId;
    }
    
    /**
     * @notice Verify if a Merkle root has been anchored
     * @param merkleRoot The root to verify
     * @return exists Whether the root has been anchored
     * @return timestamp When it was anchored (0 if not found)
     */
    function verifyMerkleRoot(bytes32 merkleRoot) external view returns (bool exists, uint256 timestamp) {
        for (uint256 i = 0; i < anchorIds.length; i++) {
            if (anchors[anchorIds[i]].merkleRoot == merkleRoot) {
                return (true, anchors[anchorIds[i]].timestamp);
            }
        }
        return (false, 0);
    }
    
    /**
     * @notice Get anchor details by ID
     */
    function getAnchor(bytes32 anchorId) external view returns (
        bytes32 merkleRoot,
        uint256 timestamp,
        uint256 leafCount,
        string memory treeId,
        bool exists
    ) {
        Anchor memory a = anchors[anchorId];
        return (a.merkleRoot, a.timestamp, a.leafCount, a.treeId, a.exists);
    }
    
    /**
     * @notice Get recent anchors
     * @param count Number of recent anchors to return
     */
    function getRecentAnchors(uint256 count) external view returns (bytes32[] memory) {
        uint256 len = anchorIds.length;
        if (count > len) count = len;
        
        bytes32[] memory recent = new bytes32[](count);
        for (uint256 i = 0; i < count; i++) {
            recent[i] = anchorIds[len - 1 - i];
        }
        return recent;
    }
    
    /**
     * @notice Transfer ownership
     */
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "DAPAnchor: new owner is zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

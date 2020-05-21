//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by panditpakhurde on 21/05/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {
    private var cache = [(feed: [LocalFeedImage], timestamp: Date)]()
    
    public init() { }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        if cache.count > 0 {
            cache.remove(at: 0)
        }
        completion(nil)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        if cache.count > 0 {
            cache[0] = (feed: feed, timestamp: timestamp)
        } else {
            cache.append((feed: feed, timestamp: timestamp))
        }
        
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        guard let result = cache.first else { return completion(.empty) }
        
        completion(.found(feed: result.feed, timestamp: result.timestamp))
    }
    
}
